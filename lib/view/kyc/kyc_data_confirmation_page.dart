import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:eidupay/controller/kyc/kyc_data_confirmation_controller.dart';
import 'package:eidupay/main.dart';
import 'package:eidupay/model/address.dart';
import 'package:eidupay/model/negara.dart';
import 'package:eidupay/model/occupation.dart';
import 'package:eidupay/widget/button/submit_button.dart';
import 'package:eidupay/widget/custom_drop_down_form_field.dart';
import 'package:eidupay/widget/custom_text_form_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eidupay/tools.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';

class KycDataConfirmationPage extends StatefulWidget {
  static final route = GetPage(
      name: '/kyc/confirmation/', page: () => const KycDataConfirmationPage());
  const KycDataConfirmationPage({Key? key}) : super(key: key);

  @override
  _KycDataConfirmationPageState createState() =>
      _KycDataConfirmationPageState();
}

class _KycDataConfirmationPageState extends State<KycDataConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Konfirmasi')),
        body: const _BodyKycDataConfirmationPage(),
      ),
    );
  }
}

class _BodyKycDataConfirmationPage extends StatefulWidget {
  const _BodyKycDataConfirmationPage({Key? key}) : super(key: key);

  @override
  _BodyKycDataConfirmationPageState createState() =>
      _BodyKycDataConfirmationPageState();
}

class _BodyKycDataConfirmationPageState
    extends State<_BodyKycDataConfirmationPage> {
  final _getController = Get.put(KycDataConfirmationController(injector.get()));
  final File _faceImage = Get.arguments[0];
  final File _ktpImage = Get.arguments[1];
  // final RecognisedText ocr = Get.arguments[2];

  @override
  void initState() {
    super.initState();
    _getController.initData();
    // _getController.setText(ocr);
    _getController.getOccupation(null, '20');
    _getController.getListProvinsi(null);
    _getController.getListNegara();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        children: [
          Text(_getController.text,
              style: const TextStyle(
                  fontSize: 16, color: t60, fontWeight: FontWeight.w400)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Form(
              key: _getController.formKey,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: _getController.nikController,
                      keyboardType: TextInputType.number,
                      title: 'NIK',
                      maxLength: 16,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _getController.nameController,
                      title: 'Nama Lengkap',
                      inputFormatters: [UpperCaseTextFormatter()],
                      maxLength: 50,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _getController.birthPlaceController,
                      title: 'Tempat Lahir',
                      inputFormatters: [UpperCaseTextFormatter()],
                      maxLength: 30,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    CustomTextFormField(
                      controller: _getController.birthDateController,
                      title: 'Tanggal Lahir',
                      keyboardType: TextInputType.number,
                      hintText: 'DD-MM-YYYY',
                      inputFormatters: [dateMaskFormatter],
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) return 'Wajib diisi';
                          if (value.isNotEmpty &&
                              !(RegExp(
                                      r"^(0[1-9]|[12][0-9]|3[01])[-](0[1-9]|1[012])[-](19|20)\d\d$")
                                  .hasMatch(value))) {
                            return 'Format harus DD-MM-YYYY';
                          }
                        }
                      },
                    ),
                    Obx(
                      () => CustomDropdownFormField(
                        title: 'Jenis Kelamin',
                        value: _getController.gender.value,
                        items: const [
                          DropdownMenuItem(
                              child: Text('Pilih jenis kelamin',
                                  style: TextStyle(color: t60)),
                              value: 'default'),
                          DropdownMenuItem(
                              child: Text('LAKI-LAKI'), value: 'laki-laki'),
                          DropdownMenuItem(
                              child: Text('PEREMPUAN'), value: 'perempuan'),
                        ],
                        onPressed: (value) {
                          if (value != null) {
                            _getController.gender.value = value;
                          }
                        },
                        validator: (value) {
                          if (value != null && value == 'default') {
                            return 'Wajib diisi';
                          }
                        },
                      ),
                    ),
                    CustomTextFormField(
                      controller: _getController.emailController,
                      title: 'Email',
                      maxLength: 50,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null) return 'Wajib diisi';
                        if (value.isEmpty) return 'Wajib diisi';
                        if (value.isNotEmpty) {
                          if (!emailValidation.hasMatch(value)) {
                            return 'Format email salah';
                          }
                        }
                      },
                    ),
                    const Text('Pekerjaan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<Occupation>(
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      isFilteredOnline: true,
                      dropdownSearchDecoration: const InputDecoration(
                        hintText: 'Masukkan nama pekerjaan',
                        hintStyle:
                            TextStyle(color: Color(0xFFD5D5DC), fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEAEBED))),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFEAEBED))),
                      ),
                      items: _getController.listOcupation.value,
                      itemAsString: (value) {
                        if (value != null) return value.occupationDetail;
                        return '';
                      },
                      onFind: (value) async {
                        if (value != null && value.isNotEmpty) {
                          final occupations =
                              await _getController.getOccupation(value, '');
                          return occupations;
                        }
                        return [];
                      },
                      onChanged: (value) {
                        if (value != null) {
                          if (value.occupationDetail != 'LAINNYA') {
                            _getController.isPekerjaanLainnya.value = false;
                            _getController.profession.value =
                                value.occupationDetail;
                          } else {
                            _getController.isPekerjaanLainnya.value = true;
                          }
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    if (!_getController.isPekerjaanLainnya.value)
                      const Text(
                        '*Pilih lainnya jika pekerjaan tidak ditemukan',
                        style: TextStyle(fontSize: 12, height: 2),
                      ),
                    if (!_getController.isPekerjaanLainnya.value)
                      const SizedBox(height: 24),
                    if (_getController.isPekerjaanLainnya.value)
                      CustomTextFormField(
                        controller: _getController.professionController,
                        title: '',
                        hintText: 'Masukkan nama pekerjaan',
                        inputFormatters: [UpperCaseTextFormatter()],
                        onChanged: (value) {
                          _getController.profession.value =
                              _getController.professionController.text;
                        },
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Wajib diisi';
                          }
                        },
                      ),
                    const SizedBox(height: 24),
                    const Text('Kewarganegaraan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<Negara>(
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      dropdownSearchDecoration: underlineInputDecoration,
                      items: _getController.dataNegara,
                      itemAsString: (value) {
                        if (value != null) {
                          return value.countryName.toUpperCase();
                        }
                        return '';
                      },
                      onFind: (value) async {
                        if (value != null && value.isNotEmpty) {
                          final negaras = <Negara>[];
                          for (final negara in _getController.dataNegara) {
                            if (negara.countryName.contains(value)) {
                              negaras.add(negara);
                            }
                          }
                          return negaras;
                        }
                        return [];
                      },
                      onChanged: (value) {
                        if (value != null) {
                          _getController.countryCode.value = value.countryCode;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: _getController.addressController,
                      title: 'Alamat',
                      maxLength: 100,
                      inputFormatters: [UpperCaseTextFormatter()],
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            controller: _getController.rtController,
                            title: 'RT',
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Wajib diisi';
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CustomTextFormField(
                            controller: _getController.rwController,
                            title: 'RW',
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Wajib diisi';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Provinsi',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<AddressData>(
                      mode: Mode.DIALOG,
                      showSearchBox: true,
                      isFilteredOnline: true,
                      dropdownSearchDecoration: underlineInputDecoration,
                      items: _getController.listProvince.value,
                      itemAsString: (value) {
                        if (value != null) return value.nama;
                        return '';
                      },
                      onFind: (value) async {
                        if (value != null && value.isNotEmpty) {
                          final provinsis =
                              await _getController.getListProvinsi(value);
                          return provinsis;
                        }
                        return [];
                      },
                      onChanged: (value) {
                        if (value != null) {
                          _getController.provinsi.value = value.nama;
                          _getController.provinsiId.value = value.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Kota',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<AddressData>(
                      mode: Mode.DIALOG,
                      enabled: _getController.provinsiId.value != 0,
                      showSearchBox: true,
                      searchDelay: const Duration(milliseconds: 500),
                      isFilteredOnline: true,
                      dropdownSearchDecoration: underlineInputDecoration,
                      itemAsString: (value) {
                        if (value != null) return value.nama;
                        return '';
                      },
                      onFind: (value) async {
                        final kotas = await _getController.getListKota(
                            value!, _getController.provinsiId.value);
                        return kotas;
                      },
                      onChanged: (value) {
                        if (value != null) {
                          _getController.kota.value = value.nama;
                          _getController.kotaId.value = value.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Kecamatan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<AddressData>(
                      mode: Mode.DIALOG,
                      enabled: _getController.kotaId.value != 0,
                      showSearchBox: true,
                      searchDelay: const Duration(milliseconds: 500),
                      isFilteredOnline: true,
                      dropdownSearchDecoration: underlineInputDecoration,
                      itemAsString: (value) {
                        if (value != null) return value.nama;
                        return '';
                      },
                      onFind: (value) async {
                        final kecamatans = await _getController
                            .getListKecamatan(value!, _getController.kotaId.value);
                        return kecamatans;
                      },
                      onChanged: (value) {
                        if (value != null) {
                          _getController.kecamatan.value = value.nama;
                          _getController.kecamatanId.value = value.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    const Text('Kelurahan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    DropdownSearch<AddressData>(
                      mode: Mode.DIALOG,
                      enabled: _getController.kecamatanId.value != 0,
                      showSearchBox: true,
                      searchDelay: const Duration(milliseconds: 500),
                      isFilteredOnline: true,
                      dropdownSearchDecoration: underlineInputDecoration,
                      itemAsString: (value) {
                        if (value != null) return value.nama;
                        return '';
                      },
                      onFind: (value) async {
                        final kelurahans =
                            await _getController.getListKelurahan(
                                value!, _getController.kecamatanId.value);
                        return kelurahans;
                      },
                      onChanged: (value) {
                        if (value != null) {
                          _getController.kelurahan.value = value.nama;
                          _getController.kelurahanId.value = value.id;
                        }
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Stack(
                      children: [
                        CustomTextFormField(
                          controller: _getController.postCodeController,
                          title: 'Kode Pos',
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Wajib diisi';
                            }
                          },
                        ),
                      ],
                    ),

                    CustomTextFormField(
                      controller: _getController.motherNameController,
                      title: 'Nama Ibu',
                      inputFormatters: [UpperCaseTextFormatter()],
                      maxLength: 50,
                      validator: (value) {
                        if (value != null && value.isEmpty) {
                          return 'Wajib diisi';
                        }
                      },
                    ),
                    // jika alamat berbeda
                    SizedBox(height: h(20)),
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: _getController.isAddressChanged.value,
                            onChanged: (val) =>
                                _getController.toggleAddressChanged(),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  _getController.toggleAddressChanged(),
                              child: Text(
                                  'Jika tempat tinggal tidak sesuai dengan alamat KTP',
                                  style:
                                      TextStyle(fontSize: w(14), color: t70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      if (_getController.isAddressChanged.value) {
                        return Container(
                          padding: const EdgeInsets.only(top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomTextFormField(
                                controller: _getController.address2Controller,
                                title: 'Alamat',
                                inputFormatters: [UpperCaseTextFormatter()],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _getController.rt2Controller,
                                      title: 'RT',
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: CustomTextFormField(
                                      controller: _getController.rw2Controller,
                                      title: 'RW',
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      validator: (value) {
                                        if (value != null && value.isEmpty) {
                                          return 'Wajib diisi';
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              const Text('Provinsi',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              DropdownSearch<AddressData>(
                                mode: Mode.DIALOG,
                                showSearchBox: true,
                                isFilteredOnline: true,
                                dropdownSearchDecoration:
                                    underlineInputDecoration,
                                itemAsString: (value) {
                                  if (value != null) return value.nama;
                                  return '';
                                },
                                onFind: (value) async {
                                  if (value != null && value.isNotEmpty) {
                                    final provinsis = await _getController
                                        .getListProvinsi(value);
                                    return provinsis;
                                  }
                                  return [];
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    _getController.provinsi2.value = value.nama;
                                    _getController.provinsiId2.value = value.id;
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              const Text('Kota',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              DropdownSearch<AddressData>(
                                mode: Mode.DIALOG,
                                enabled: _getController.provinsiId2.value != 0,
                                showSearchBox: true,
                                searchDelay: const Duration(milliseconds: 500),
                                isFilteredOnline: true,
                                dropdownSearchDecoration:
                                    underlineInputDecoration,
                                itemAsString: (value) {
                                  if (value != null) return value.nama;
                                  return '';
                                },
                                onFind: (value) async {
                                  final kotas =
                                      await _getController.getListKota(
                                          '', _getController.provinsiId2.value);
                                  return kotas;
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    _getController.kota2.value = value.nama;
                                    _getController.kotaId2.value = value.id;
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              const Text('Kecamatan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              DropdownSearch<AddressData>(
                                mode: Mode.DIALOG,
                                enabled: _getController.kotaId2.value != 0,
                                showSearchBox: true,
                                searchDelay: const Duration(milliseconds: 500),
                                isFilteredOnline: true,
                                dropdownSearchDecoration:
                                    underlineInputDecoration,
                                itemAsString: (value) {
                                  if (value != null) return value.nama;
                                  return '';
                                },
                                onFind: (value) async {
                                  final kecamatans =
                                      await _getController.getListKecamatan(
                                          '', _getController.kotaId2.value);
                                  return kecamatans;
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    _getController.kecamatan2.value =
                                        value.nama;
                                    _getController.kecamatanId2.value =
                                        value.id;
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              const Text('Kelurahan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              DropdownSearch<AddressData>(
                                mode: Mode.DIALOG,
                                enabled: _getController.kecamatanId2.value != 0,
                                showSearchBox: true,
                                searchDelay: const Duration(milliseconds: 500),
                                isFilteredOnline: true,
                                dropdownSearchDecoration:
                                    underlineInputDecoration,
                                itemAsString: (value) {
                                  if (value != null) return value.nama;
                                  return '';
                                },
                                onFind: (value) async {
                                  final kelurahans =
                                      await _getController.getListKelurahan('',
                                          _getController.kecamatanId2.value);
                                  return kelurahans;
                                },
                                onChanged: (value) {
                                  if (value != null) {
                                    _getController.kelurahan2.value =
                                        value.nama;
                                    _getController.kelurahanId2.value =
                                        value.id;
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                              const SizedBox(height: 24),
                              CustomTextFormField(
                                controller: _getController.postCode2Controller,
                                title: 'Kode Pos',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: (value) {
                                  if (value != null && value.isEmpty) {
                                    return 'Wajib diisi';
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                              value: _getController.isChecked.value,
                              onChanged: (_) =>
                                  _getController.toggleStatementCheck()),
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  _getController.toggleStatementCheck(),
                              child: Text(_getController.statementText,
                                  style: const TextStyle(
                                      fontSize: 14, color: t70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => SubmitButton(
              text: 'Lanjut',
              backgroundColor: green,
              onPressed: _getController.isChecked.value
                  ? () async =>
                      await _getController.process(_faceImage, _ktpImage)
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
