import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tenant_controller.dart';

class TenantView extends GetView<TenantController> {
  const TenantView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Tenant')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(labelText: 'Company Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.adminEmailController,
              decoration: InputDecoration(labelText: 'Admin Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.adminPasswordController,
              decoration: InputDecoration(labelText: 'Admin Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.startTimeController,
              decoration: InputDecoration(labelText: 'Start Time (HH:mm)'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: controller.endTimeController,
              decoration: InputDecoration(labelText: 'End Time (HH:mm)'),
            ),
            SizedBox(height: 16.0),
            Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.createTenant,
                  child: controller.isLoading.value
                      ? CircularProgressIndicator()
                      : Text('Create Tenant'),
                )),
          ],
        ),
      ),
    );
  }
}
