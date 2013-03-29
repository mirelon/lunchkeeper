$ ->
  if gon? and $('#highchart-container-pie').length>0
    console.log gon.data
    pie_chart = new Highcharts.Chart
      chart:
        renderTo: "highchart-container-pie"
        type: "pie"

      title:
        text: gon.title

      series:
        [
          name: "Pie chart",
          data: gon.data
        ]