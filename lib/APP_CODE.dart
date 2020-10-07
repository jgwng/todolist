library todolist.globals;

String Save = "SaveMemo";
String Secret = "SecretMemo";
String MainScreenTitle = 'MainTitle';
String DetailMemo = "MemoDetail";
String EditingMemo="EditingMemo";
String SettingPassWordTitle = 'SettingPassWordTitle';
String CheckingPassWordTitle = 'CheckingPassWordTitle';
String PassWord = "PassWord";
String checkFirstTime = "isFirst";
String DatabaseName  = 'whattodo';
String MemoAdd = "AddMemo";
String MultiSelect = "MultiDel";


String secretMode = "SecretMode";
String DialogTitle = "DG_Title";
String DialogContent = "DG_Content";
String DialogYes = "Yes";
String DialogNo = "No";

String secretDialog = "SecretDialog";

String DB_MemoTitle = 'title';
String DB_MemoMessage = 'message';
String DB_Check = 'checked';
String DB_Secret = 'Secret';




// 해당 앱내에 변수 글로벌하게 쓰는 방법
// 1. 프로젝트이름.globals -> 쓰려고 하는 변수들 작성
// 2. 쓰려고하는 파일에서 import '변수 작성한 파일명.dart' as globals
// 3. globals.선언한 변수명 으로 사용하면 된다.


//print('가로 : ' + MediaQuery.of(context).size.width.toInt().toString());  // 가로 해상도
//print('세로 : ' + MediaQuery.of(context).size.height.toInt().toString()); // 세로 해상도