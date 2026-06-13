import { BreakPointType } from '../commons/BreakPointUtil';

@Entry
@Component
struct Index {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';

  build() {
    Flex({justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center}) {
      Text(this.currentBreakpoint).fontSize(50).fontWeight(FontWeight.Medium)
      Image(
        new BreakPointType({
          sm: $r('app.media.ic_nav_01'),
          md: $r('app.media.ic_nav_02'),
          lg: $r('app.media.ic_nav_03')
        }).getValue(this.currentBreakpoint)
      )
    }
    .width(200)
    .height(200)
    .backgroundColor(
      new BreakPointType({
        sm: Color.Black,
        md: Color.Red,
        lg: Color.Green
      }).getValue(this.currentBreakpoint)
    )
  }
}