$ ->
  if gon?
    console.log gon.data
    chart = new Highcharts.Chart
      chart:
        renderTo: "highchart-container"
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