class Video {
  String videoUrl;
  String title;

  Video({this.videoUrl, this.title});
}

List videos = [
  Video(
    videoUrl: 'https://www.youtube.com/watch?v=BO0y7FPO3tk',
    title: 'Dúvidas? Chama o Ministério da Saúde no WhatsApp!',
  ),
  Video(
    videoUrl: 'https://www.youtube.com/watch?v=6FFsEjUjHoc',
    title: 'Coronavírus: O que você precisa saber e fazer.',
  ),
  Video(
    videoUrl: 'https://www.youtube.com/watch?v=C83jhuQMWqc',
    title:
        'É necessário a higienização correta das mãos no combate ao COVID-19!',
  ),
  Video(
    videoUrl: 'https://www.youtube.com/watch?v=IlqwgyhBE0w',
    title: 'Suspeita? Se consulte mesmo sem sair de casa!',
  ),
];
