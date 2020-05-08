class Dica {
  String imageUrl;
  String title;
  String text;

  Dica({this.imageUrl, this.text, this.title});
}

List dicas = [
  Dica(
    imageUrl:
        "assets/images/helptab/help-1.jpg",
    title:
        "Lavar as mãos é uma das principais formas de prevenção contra o Coronavírus",
    text:
        "Uma medida simples, barata e eficiente pode prevenir complicações na saúde de pessoas, principalmente aquelas causadas por vírus, micróbios e bactérias: lavar corretamente as mãos. Afinal, elas estão sempre em contato com superfícies ou objetos contaminados.",
  ),
  Dica(
    imageUrl:
        "assets/images/helptab/help-2.jpg",
    title: 'Use máscara ao sair em público',
    text:
        "Em meio a atual crise pandêmica do novo coronavírus (COVID-19), o Ministério da Saúde (MS) recomenda à população o uso de máscaras, incluindo as de tecido. Usar máscaras de tecido é uma alternativa de grande importância para a população saudável, pois bloqueia duas portas de entrada do coronavírus: a boca e o nariz. É importante ressaltar que a máscara de tecido deve ser lavada após o uso, para evitar transporte de doenças para a sua casa.",
  ),
  Dica(
      imageUrl:
            "assets/images/helptab/help-3.jpg",
      title: 'Lempre-se de sempre higienizar objetos pessoais',
      text:
          "Celulares, notebooks e outros objetos de uso pessoal devem ser limpos com frequência. Aparelhos eletrônicos devem ser limpos com álcool isopropílico."),
  Dica(
      imageUrl:
            "assets/images/helptab/help-4.jpg",
      title: 'Matenha distância na compra e na entrega de produtos',
      text:
          "Use sempre luvas, sacolas e máscaras descartaveis ao entregar ou receber produtos, desta forma você garante a segurança dos demais e dificulta a propagação do vírus."),
  Dica(
      imageUrl:
            "assets/images/helptab/help-5.jpg",
      title: 'Use sempre álcool em gel',
      text: "Considerado um antisséptico, o álcool em gel ajuda evitar o contágio pelo covid-19. O recomendado pela Organização Mundial da Saúde (OMS) é usar soluções onde há  concentração de 70% de álcool etílico. Especialistas alertam que o uso do álcool em gel deve ser feito caso não tenha água e sabão por perto."),
];
