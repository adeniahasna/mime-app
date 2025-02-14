import 'package:flutter/material.dart';
import 'package:flutter_app/config/assets_image.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:intl/intl.dart';

class TaskListPage extends NyStatefulWidget {
  static RouteView path = ("/task-list", (_) => TaskListPage());

  TaskListPage({super.key}) : super(child: () => _TaskListPageState());
}

class _TaskListPageState extends NyPage<TaskListPage> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  Map<String, List<Map<String, String>>> tasks = {};

  void _changeMonth(int offset) {
    setState(() {
      currentMonth =
          DateTime(currentMonth.year, currentMonth.month + offset, 1);
    });
  }

  void _selectDate(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  void _addTask(String task, DateTime startDate, TimeOfDay startTime,
      DateTime endDate, TimeOfDay endTime) {
    for (DateTime date = startDate;
        date.isBefore(endDate.add(Duration(days: 1)));
        date = date.add(Duration(days: 1))) {
      String key = DateFormat('yyyy-MM-dd').format(date);
      if (!tasks.containsKey(key)) {
        tasks[key] = [];
      }
      tasks[key]!.add({
        "task": task,
        "startTime": startTime.format(context),
        "endTime": endTime.format(context),
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 18,
                  child: Image.asset(AssetImages.logo),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          _buildMonthSelector(),
          _buildCalendar(),
          Expanded(child: _buildTaskList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildMonthSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(Icons.arrow_back), onPressed: () => _changeMonth(-1)),
        Text(DateFormat('MMMM yyyy').format(currentMonth),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        IconButton(
            icon: Icon(Icons.arrow_forward), onPressed: () => _changeMonth(1)),
      ],
    );
  }

  Widget _buildCalendar() {
    int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          DateTime date =
              DateTime(currentMonth.year, currentMonth.month, index + 1);
          bool isSelected =
              selectedDate.day == date.day && selectedDate.month == date.month;
          bool hasTask =
              tasks.containsKey(DateFormat('yyyy-MM-dd').format(date));
          String dayName = DateFormat('E').format(date).substring(0, 2);
          return GestureDetector(
            onTap: () => _selectDate(date),
            child: Column(
              children: [
                Text(
                  dayName,
                  style: TextStyle(
                      color: const Color.fromARGB(255, 39, 23, 23),
                      fontSize: 12),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('${index + 1}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                    if (hasTask)
                      Positioned(
                        top: -1,
                        right: 3,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.indigo[900],
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTaskList() {
    String key = DateFormat('yyyy-MM-dd').format(selectedDate);
    List<Map<String, String>> taskList = tasks[key] ?? [];
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(taskList[index]["task"]!),
          subtitle: Text(
              "${taskList[index]["startTime"]} - ${taskList[index]["endTime"]}"),
        );
      },
    );
  }

  void _showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();
    DateTime startDate = selectedDate;
    DateTime endDate = selectedDate;
    TimeOfDay startTime = TimeOfDay.now();
    TimeOfDay endTime = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Tambah Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                  controller: taskController,
                  decoration: InputDecoration(labelText: "Task")),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                      context: context, initialTime: startTime);
                  if (picked != null) startTime = picked;
                },
                child: Text("Pilih Start Time"),
              ),
              ElevatedButton(
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                      context: context, initialTime: endTime);
                  if (picked != null) endTime = picked;
                },
                child: Text("Pilih End Time"),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (picked != null) startDate = picked;
                },
                child: Text("Pilih Start Date"),
              ),
              ElevatedButton(
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: endDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));
                  if (picked != null) endDate = picked;
                },
                child: Text("Pilih End Date"),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text("Batal")),
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  _addTask(taskController.text, startDate, startTime, endDate,
                      endTime);
                  Navigator.pop(context);
                }
              },
              child: Text("Tambah"),
            ),
          ],
        );
      },
    );
  }
}
