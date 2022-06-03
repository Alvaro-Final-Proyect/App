import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:padel/core/retrofit_helper.dart';
import 'package:padel/screens/update_user_screen/update_user_controller.dart';
import 'package:padel/util/image_extensions.dart';
import 'package:padel/widgets/custom_checkbox.dart';
import 'package:padel/widgets/input.dart';
import 'package:searchfield/searchfield.dart';

import '../create_user_screen/create_user_body.dart';

class UpdateUserBody extends StatelessWidget {
  UpdateUserBody({Key? key}) : super(key: key);

  final _updateUserController = Get.find<UpdateUserController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(
            () {
              return _updateUserController.isSearching
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: SearchField(
                        hasOverlay: false,
                        suggestions: _updateUserController.users.where((usr) => usr.id != RetrofitHelper.user!.id).map(
                          (e) {
                            return SearchFieldListItem(
                              e.username!,
                              child: ListTile(
                                title: Text(e.username!),
                                leading: CircleAvatar(
                                  backgroundImage: ImageExtensions.fromUser(e),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        controller: _updateUserController.searchInputController,
                        marginColor: Get.theme.colorScheme.onPrimaryContainer,
                        itemHeight: 60,
                        hint: 'textUsername'.tr,
                        searchInputDecoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                              width: 3.0,
                            ),
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                        suggestionAction: SuggestionAction.unfocus,
                        onSuggestionTap: (selected) =>
                            setSelection(selected.searchKey),
                        onSubmit: setSelection,
                        suggestionItemDecoration: BoxDecoration(
                            color: Get.theme.colorScheme.onSurface),
                      ),
                    )
                  : Obx(
                      () {
                        return _updateUserController.selectedUser == null
                            ? Center(
                                child: Text('textSearchAnUser'.tr),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Input(
                                      initialValue: _updateUserController
                                          .selectedUser!.username!,
                                      label: 'textUsername'.tr,
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 10),
                                      controller: _updateUserController
                                          .usernameController,
                                      onChanged: (value) {
                                        _updateUserController.usernameController
                                            .onChanged(value);
                                        _updateUserController.usernameController
                                            .validate(values: {
                                          'usernames': _updateUserController
                                              .usernames
                                              .where((element) =>
                                                  element !=
                                                  _updateUserController
                                                      .selectedUser!.username).toList()
                                        });
                                      },
                                    ),
                                    Input(
                                      initialValue: _updateUserController
                                          .selectedUser!.email!,
                                      label: 'textEmail'.tr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      controller:
                                          _updateUserController.emailController,
                                      onChanged: (value) {
                                        _updateUserController.emailController
                                            .onChanged(value);
                                        _updateUserController.emailController
                                            .validate(values: {
                                          'emails': _updateUserController
                                              .emails
                                              .where((element) =>
                                          element !=
                                              _updateUserController
                                                  .selectedUser!.email).toList()
                                        });
                                      },
                                    ),
                                    Input(
                                      initialValue: _updateUserController
                                          .selectedUser!.name!,
                                      label: 'textName'.tr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      controller:
                                          _updateUserController.nameController,
                                      onChanged: (value) {
                                        _updateUserController.nameController
                                            .onChanged(value);
                                        _updateUserController.nameController
                                            .validate();
                                      },
                                    ),
                                    Input(
                                      initialValue: _updateUserController
                                          .selectedUser!.surname!,
                                      label: 'textSurname'.tr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      controller: _updateUserController
                                          .surnameController,
                                      onChanged: (value) {
                                        _updateUserController.surnameController
                                            .onChanged(value);
                                        _updateUserController.surnameController
                                            .validate();
                                      },
                                    ),
                                    Input(
                                      initialValue: _updateUserController
                                          .levelController.text,
                                      label: 'textLevel'.tr,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      controller:
                                          _updateUserController.levelController,
                                      onChanged: (value) {
                                        _updateUserController.levelController
                                            .onChanged(value);
                                        _updateUserController.levelController
                                            .validate();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 5),
                                      child: CustomCheckbox(
                                        checkboxController: CheckboxController(
                                          initial: _updateUserController
                                              .isAdminController
                                              .isChecked
                                              .value,
                                        ),
                                        title: 'textIsAdmin'.tr,
                                      ),
                                    ),
                                    // Position
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 5),
                                      child: DropdownButtonFormField<Position>(
                                        items: Position.values.map(
                                          (position) {
                                            return DropdownMenuItem(
                                              value: position,
                                              child: Text(
                                                'text${position.name.capitalize ?? ''}Position'
                                                    .tr,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: _updateUserController
                                            .positionController.onChanged,
                                        hint: Text('textSelectYourPosition'.tr),
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  width: 3.0)),
                                          prefixIcon: const Icon(
                                              FontAwesomeIcons
                                                  .tableTennisPaddleBall),
                                        ),
                                        value: _updateUserController
                                            .positionController.selected,
                                      ),
                                    ),
                                    // Gender
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 5, 20, 5),
                                      child: DropdownButtonFormField<Gender>(
                                        items: Gender.values.map(
                                          (gender) {
                                            return DropdownMenuItem(
                                              value: gender,
                                              child: Text(
                                                'text${gender.name.capitalize ?? ''}'
                                                    .tr,
                                              ),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: _updateUserController
                                            .genderController.onChanged,
                                        hint: Text('textSelectYourGender'.tr),
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurface,
                                                  width: 3.0)),
                                          prefixIcon: Obx(
                                            () {
                                              switch (_updateUserController
                                                  .genderController.selected) {
                                                case Gender.male:
                                                  return const Icon(Icons.man);
                                                case Gender.female:
                                                  return const Icon(
                                                      Icons.woman);
                                                default:
                                                  return const Icon(
                                                      Icons.elderly_woman);
                                              }
                                            },
                                          ),
                                        ),
                                        value: _updateUserController
                                            .genderController.selected,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      },
                    );
            },
          ),
        ],
      ),
    );
  }

  void setSelection(String username) {
    _updateUserController.selectedUser = _updateUserController.users
        .firstWhere((element) => element.username == username);

    if (_updateUserController.selectedUser != null) {
      _updateUserController.isSearching = false;
    }
  }
}
