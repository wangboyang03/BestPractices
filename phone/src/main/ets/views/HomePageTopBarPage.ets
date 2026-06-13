@Entry
@Component
struct HomePageTopBarPage {
  build() {
    GridRow({
      columns: {
        sm: 12,
        md: 12,
        lg: 12
      },
      gutter: {
        x: 10,
        y: 10
      }
    }) {
      GridCol({
        span: {
          sm: 12,
          md: 12,
          lg: 8
        }
      }) {
        Row() {
          Text('首页')
            .fontColor('#000000')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .height(40)
      }

      GridCol({
        span: {
          sm: 12,
          md: 12,
          lg: 4
        }
      }) {
        Row() {
          Search({ placeholder: '搜索' })
            .searchIcon({
              src: $r('app.media.ic_public_input_search')
            })
            .placeholderFont({ size: 16 })
            .placeholderColor('#000000')
            .backgroundColor('#FFFFFF')
            .margin({ top: 4 })
            .borderRadius(45)
        }
        .width('100%')
        .height(40)
      }
      .layoutWeight(1)
    }
    .width('100%')
    .padding(20)
    .backgroundColor($r('sys.color.container_modal_button_hover_baseboard'))
  }
}