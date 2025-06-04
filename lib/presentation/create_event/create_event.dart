import 'package:evently_app/core/extensions/date_extensions.dart';
import 'package:evently_app/core/extensions/string_extension.dart';
import 'package:evently_app/core/resources/colors_manager/colors_manager.dart';
import 'package:evently_app/core/resources/constants_manager.dart';
import 'package:evently_app/core/resources/dialog_utils.dart';
import 'package:evently_app/core/routes_manager/routes_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/data/DM/category_DM.dart';
import 'package:evently_app/data/DM/event_DM.dart';
import 'package:evently_app/data/DM/user_DM.dart';
import 'package:evently_app/data/firebase_services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key, this.event});

  final EventDm? event;

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  CategoryDM selectedCategory = ConstantsManager.categoriesWithoutAll[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LatLng? location;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    initEditData();
  }

  initEditData() {
    if (widget.event != null) {
      titleController.text = widget.event!.title;
      descriptionController.text = widget.event!.description;
      selectedCategory = widget.event!.category;
      selectedDate = widget.event!.dateTime;
      selectedTime = TimeOfDay(
        hour: widget.event!.dateTime.hour,
        minute: widget.event!.dateTime.minute,
      );
      location = LatLng(widget.event!.lat!, widget.event!.lng!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.event == null
              ? AppLocalizations.of(context)!.create_event
              : "Update event",
        ),
      ),
      body: Padding(
        padding: REdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(selectedCategory.imagePath),
                ),
                CustomTabBar(
                  initialIndex: ConstantsManager.categoriesWithoutAll.indexOf(
                    selectedCategory,
                  ),
                  categories: ConstantsManager.categoriesWithoutAll,
                  selectedLabelBg: ColorsManager.light,
                  selectedTabBg: ColorsManager.blue,
                  unselectedLabelBg: ColorsManager.blue,
                  unselectedTabBg: ColorsManager.light,
                  verticalPadding: 16,
                  onCategoryTabClicked: onCategoryItemClicked,
                ),
                Text(
                  AppLocalizations.of(context)!.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  labelText: AppLocalizations.of(context)!.event_title,
                  prefixIcon: Icons.edit_note_outlined,
                  controller: titleController,
                  validator: onTitleValidate,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 8.h),
                CustomTextFormField(
                  labelText: AppLocalizations.of(context)!.event_description,
                  maxLines: 3,
                  controller: descriptionController,
                  validator: onDescriptionValidate,
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Icon(Icons.date_range),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        selectedDate.toFormattedYear,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    CustomTextButton(
                      text: AppLocalizations.of(context)!.choose_date,
                      onPress: _showEventDate,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.access_time_rounded),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        selectedDate.getTimeFormatted,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    CustomTextButton(
                      text: AppLocalizations.of(context)!.choose_time,
                      onPress: _showEventTime,
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutesManager.selectedLocation,
                    ).then((value) {
                      if (value != null) {
                        location = value as LatLng;
                        setState(() {});
                      }
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    side: BorderSide(color: ColorsManager.blue, width: 1.w),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorsManager.blue,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: REdgeInsets.all(8),
                          child: Icon(
                            Icons.my_location,
                            color: ColorsManager.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        flex: 9,
                        child: Text(
                          location != null
                              ? "${location!.latitude} , ${location!.longitude} "
                              : "Choose Event Location",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: ColorsManager.blue),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                CustomElevatedButton(
                  text:
                      widget.event == null
                          ? AppLocalizations.of(context)!.add_event
                          : "update event",
                  onPress: widget.event == null ? _createEvent : updateEvent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onCategoryItemClicked(CategoryDM category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void _createEvent() async {
    if (!formKey.currentState!.validate()) return;
    try {
      EventDm eventDm = EventDm(
        userId: UserDm.currentUser!.id,
        category: selectedCategory,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: selectedDate.copyWith(
          hour: selectedTime.hour,
          minute: selectedTime.minute,
        ),
        lat: location!.latitude,
        lng: location!.longitude,
      );
      await FirebaseServices.addEventsToFireStore(eventDm);
      Navigator.pop(context);
    } catch (exception) {
      print(exception.toString());
    }
  }

  updateEvent() async {
    if (!formKey.currentState!.validate()) return;

    EventDm event = EventDm(
      id: widget.event!.id,
      userId: UserDm.currentUser!.id,
      category: selectedCategory,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate.copyWith(
        hour: selectedTime.hour,
        minute: selectedTime.minute,
      ),
      lat: location!.latitude,
      lng: location!.longitude,
    );
    DialogUtils.showLoadingDialog("loading...", context);
    await FirebaseServices.updateEventData(event);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: "Are you sure you want to update this event",
      posActionTitle: "yes",
      posAction: () {
        Navigator.pushNamed(context, RoutesManager.mainLayout);
      },
      negActionTitle: "No",
    );
  }

  void _showEventDate() async {
    selectedDate =
        await showDatePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;

    setState(() {});
  }

  void _showEventTime() async {
    selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now()) ??
        selectedTime;

    selectedDate = selectedDate.copyWith(
      hour: selectedTime.hour,
      minute: selectedTime.minute,
    );
    setState(() {});
  }

  String? onTitleValidate(String? input) {
    if (input == null || input.trim().isEmpty) {
      return "Please enter event title";
    }
    return null;
  }

  String? onDescriptionValidate(String? input) {
    if (input == null || input.trim().isEmpty) {
      return "Please enter event Description";
    }
    if (input.getStringWithoutSpaces.length < 6) {
      return " event Description must be at least 6 characters";
    }
    return null;
  }
}
