import { BreakPointType } from '../commons/BreakPointUtil'

@Entry
@Component
struct HomePageTopBarPage {
  @StorageProp('currentBreakpoint') currentPoint:string = 'md'
  build() {
    Flex({
      wrap: FlexWrap.Wrap
    }) {
      Row() {
        Text('首页')
          .fontColor('#000000')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .width('100%')
      }
      // .padding({bottom: 10})
      .width(new BreakPointType({
        sm: '100%',
        md: '100%',
        lg: '75%'
      }).getValue(this.currentPoint))
      .height(40)

      Row() {
        Search({ placeholder: '搜索'})
          .searchIcon({
            src: $r('app.media.ic_public_input_search')
          })
          .placeholderFont({ size: 16 })
          .placeholderColor('#000000')
          .width('100%')
          .backgroundColor('#FFFFFF')
          .margin({ top: 4 })
          .borderRadius(45)
          .borderWidth(1)
          .borderColor('#000000')
      }
      .width(new BreakPointType({
        sm: '100%',
        md: '100%',
        lg: '25%'
      }).getValue(this.currentPoint))
      .height(40)
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor($r('sys.color.container_modal_button_hover_baseboard'))
  }
}