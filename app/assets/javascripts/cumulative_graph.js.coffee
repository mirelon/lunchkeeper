$ ->
  if gon? and $('#highchart-container-cumulative').length>0
    console.log gon.data
    pie_chart = new Highcharts.Chart
      chart:
        renderTo: "highchart-container-cumulative"
        type: "spline"
        zoomType: "x"

      title:
        text: gon.title

      xAxis:
        type: "datetime"

      yAxis:
        startOnTick: false,
        title:
          text: "Cumulative count"

      plotOptions:
        spline:
          marker:
            enabled: false

      series:
        [
          name: "Cumulative graph",
          data: gon.data
        ]