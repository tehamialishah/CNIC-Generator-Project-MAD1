import 'dart:html';
import 'package:intl/intl.dart';
import 'dart:math';

void main() {
  var firstName = querySelector('.name') as InputElement;
  var lastName = querySelector('.lastName') as InputElement;
  var fatherName = querySelector('.fatherName') as InputElement;
  var gender = querySelector('.gender') as InputElement;
  var areaCode = querySelector('.areaCode') as SelectElement;
  var dateOfBirth = querySelector('.date') as DateInputElement;
  var img = querySelector('.img-upload') as FileUploadInputElement;
  var form = querySelector('.form') as FormElement;
  var cNIC = querySelector('.userIdDetails') as DivElement;

  // ======================================================//

  //=====================printed id's======================//

  var nameText = querySelector('.name-text') as SpanElement;
  var fatherNameText = querySelector('.father-name-text') as SpanElement;
  var genderText = querySelector('.gender-text') as SpanElement;
  var countryText = querySelector('.country-text') as SpanElement;
  var cnicText = querySelector('.cnic-text') as SpanElement;
  var dateOfBirthText = querySelector('.DOB-text') as SpanElement;
  var issueDateText = querySelector('.issD-text') as SpanElement;
  var expiryDateText = querySelector('.expD-text') as SpanElement;
  var mainProfile = querySelector('.main-profile-img') as ImageElement;
  var smallProfileImg = querySelector('.small-profile-img') as ImageElement;
  var signatureText = querySelector('.signature-text') as SpanElement;

  //========================================================//

  form.onSubmit.listen((event) {
    event.preventDefault();
    var fName = '${firstName.value} ${lastName.value}';
    var fullName = capitalizeEachWord(fName);
    var faName = '${fatherName.value}';
    var fullFatherName = capitalizeEachWord(faName);
    var dateOfBirthRev = dateOfBirth.value!.split('-').reversed;
    var compDateOfBirth = [];
    compDateOfBirth.addAll(dateOfBirthRev);
    var dObDay = compDateOfBirth[0].toString();
    var dObMonth = compDateOfBirth[1].toString();
    var dObYear = compDateOfBirth[2].toString();
    var sig = signature('${firstName.value}');

    // date of birth month convert Numeric value into Alphabetically //

    var now = DateTime.now();
    var formatter = DateFormat('dd, MMM, yyyy');
    var formattedDate = formatter.format(now);
    var dateIssue = [];
    dateIssue.addAll(formattedDate.split(','));
    var expDate = [];
    expDate.addAll(formattedDate.split(','));
    expDate[2] = now.year + 5;
    var expYDate = expDate;
    var expiryDate = expYDate.join('-');
    var comIssueDate = dateIssue.join('-');

    var month = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Nev',
      'Dec'
    ];

    String? actuatMonth;

    if (dObMonth == '01') {
      actuatMonth = month[0];
      dObMonth = actuatMonth;
    } else if (dObMonth == '02') {
      actuatMonth = month[1];
      dObMonth = actuatMonth;
    } else if (dObMonth == '03') {
      actuatMonth = month[2];
      dObMonth = actuatMonth;
    } else if (dObMonth == '04') {
      actuatMonth = month[3];
      dObMonth = actuatMonth;
    } else if (dObMonth == '05') {
      actuatMonth = month[4];
      dObMonth = actuatMonth;
    } else if (dObMonth == '06') {
      actuatMonth = month[5];
      dObMonth = actuatMonth;
    } else if (dObMonth == '07') {
      actuatMonth = month[6];
      dObMonth = actuatMonth;
    } else if (dObMonth == '08') {
      actuatMonth = month[7];
      dObMonth = actuatMonth;
    } else if (dObMonth == '09') {
      actuatMonth = month[8];
      dObMonth = actuatMonth;
    } else if (dObMonth == '10') {
      actuatMonth = month[9];
      dObMonth = actuatMonth;
    } else if (dObMonth == '11') {
      actuatMonth = month[10];
      dObMonth = actuatMonth;
    } else if (dObMonth == '12') {
      actuatMonth = month[11];
      dObMonth = actuatMonth;
    }

    var userDateOfBirth = '$dObDay-$dObMonth-$dObYear';

    var id = '';
    var length = 8;
    var eightDigit = [];

    for (var i = 0; i < length; i++) {
      id += Random().nextInt(10).toString();
    }
    var idNum = id.split('');
    eightDigit.addAll(idNum);

    var compCnicID =
        '${eightDigit[0]}${eightDigit[1]}${eightDigit[2]}${eightDigit[3]}${eightDigit[4]}${eightDigit[5]}${eightDigit[6]}-${eightDigit[7]}';

    if (gender.value!.toLowerCase() == 'male') {
      gender.value = 'M';
    } else if (gender.value!.toLowerCase() == 'female') {
      gender.value = 'F';
    } else {
      window.alert(
          'Your Gender Value ${gender.value} is Incorrect\nPlease input Correct value to process');
    }

    if (img.files!.isNotEmpty) {
      var file = img.files!.first;
      var reader = FileReader();

      reader.onLoad.listen((e) {
        cNIC.style.display = 'flex';
        mainProfile.src = reader.result as String?;
        smallProfileImg.src = reader.result as String?;
        nameText.text = fullName;
        fatherNameText.text = fullFatherName;
        genderText.text = gender.value;
        countryText.text = 'Pakistan';
        dateOfBirthText.text = userDateOfBirth;
        if (areaCode.value == 'Select Your Area Code') {
          window.alert('please select your area code correctly');
          cNIC.style.display = 'none';
        } else {
          cNIC.style.display = 'flex';
        }
        cnicText.text = '${areaCode.value}-$compCnicID';
        issueDateText.text = comIssueDate;
        expiryDateText.text = expiryDate;
        signatureText.text = sig;
      });

      reader.readAsDataUrl(file);
    }
  });
}

String signature(String str) {
  List<String> words = str.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }

  String result = words.join(' ');
  return result;
}

String capitalizeEachWord(String str) {
  List<String> words = str.split(' ');

  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] =
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
  }

  String result = words.join(' ');
  return result;
}
