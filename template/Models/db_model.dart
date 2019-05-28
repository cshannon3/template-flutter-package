class SampleDBModel {
  final String gameType;
  final double score;
  final String time;
  final String date;

  SampleDBModel({
    this.gameType,
    this.score,
    this.time,
    this.date,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['game_type'] = gameType;
    map['score'] = score;
    map['time'] = time;
    map['date'] = date;

    return map;
  }
    String sqlTable(){
    String res = "id INTEGER PRIMARY KEY,";
    res+= 'game_type TEXT, score REAL, time TEXT, date TEXT';

    return res;
  } 


  SampleDBModel.fromOfflineDB(Map map)
      : gameType = map["game_type"],
        score = map["score"],
        time = map["time"],
        date = map["date"];
  
  

}