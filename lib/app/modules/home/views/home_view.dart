import 'package:attendance_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:attendance_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:attendance_flutter/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  final LoginController loginController = Get.put(LoginController());
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Theme Demo'),
      //   actions: [
      //     IconButton(
      //       onPressed: () => loginController.logout(),
      //       icon: Icon(Icons.logout_rounded),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              child: Container(
                height: 400,
                color: Colors.purpleAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buttons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Elevated Button
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Elevated Button'),
                  ),
                  const SizedBox(height: 8),

                  // Text Button
                  TextButton(
                    onPressed: () {},
                    child: const Text('Text Button'),
                  ),
                  const SizedBox(height: 8),

                  // Outlined Button
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('Outlined Button'),
                  ),
                  const SizedBox(height: 24),

                  // TextFormField
                  const Text(
                    'Text Fields',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.email),
                      errorText: 'Invalid email format',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Card
                  const Text(
                    'Card',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Card Title',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'This is a card with some content. Cards can be used to display information in a contained format.',
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: const Text('CANCEL'),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Switches, Checkboxes, and Radio buttons
                  const Text(
                    'Selection Controls',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // We need a StatefulBuilder for these widgets
                  StatefulBuilder(
                    builder: (context, setState) {
                      bool switchValue = true;
                      bool checkboxValue = true;
                      int radioValue = 1;

                      return Column(
                        children: [
                          // Switch
                          ListTile(
                            title: const Text('Switch'),
                            trailing: Switch(
                              value: switchValue,
                              onChanged: (value) {
                                setState(() {
                                  switchValue = value;
                                });
                              },
                            ),
                          ),

                          // Checkbox
                          ListTile(
                            title: const Text('Checkbox'),
                            trailing: Checkbox(
                              value: checkboxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue = value!;
                                });
                              },
                            ),
                          ),

                          // Radio
                          ListTile(
                            title: const Text('Radio Option 1'),
                            trailing: Radio<int>(
                              value: 1,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text('Radio Option 2'),
                            trailing: Radio<int>(
                              value: 2,
                              groupValue: radioValue,
                              onChanged: (value) {
                                setState(() {
                                  radioValue = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 24),

                  // Slider
                  const Text(
                    'Slider',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  StatefulBuilder(
                    builder: (context, setState) {
                      double sliderValue = 0.5;

                      return Slider(
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (_) {},
      ),
    );
  }
}


