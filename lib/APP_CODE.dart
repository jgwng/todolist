library todolist.globals;

String MainScreenTitle = 'MainTitle';
String DetailMemo = "MemoDetail";
String EditingMemo="EditingMemo";
String SettingPassWordTitle = '설정하실 비밀번호를 입력하세요';
String CheckingPassWordTitle = '설정하신 비밀번호를 입력하세요';
String PassWord = "PassWord";
String checkFirstTime = "isFirst";
String DatabaseName  = 'whattodo';

String DB_MemoTitle = 'title';
String DB_MemoMessage = 'message';
String DB_Check = 'checked';

// 해당 앱내에 변수 글로벌하게 쓰는 방법
// 1. 프로젝트이름.globals -> 쓰려고 하는 변수들 작성
// 2. 쓰려고하는 파일에서 import '변수 작성한 파일명.dart' as globals
// 3. globals.선언한 변수명 으로 사용하면 된다.


//print('가로 : ' + MediaQuery.of(context).size.width.toInt().toString());  // 가로 해상도
//print('세로 : ' + MediaQuery.of(context).size.height.toInt().toString()); // 세로 해상도