@Entry
@Component
struct GridPage {
  @State currentBreakPoint: string = 'sm'

  build() {
    Column() {
      // GridRow 默认支持 4 个断点
      //  xs:(0vp<=width<320vp) 智能穿戴，比如手表
      //  sm:(320vp<=width<600vp) 手机
      //  md:(600vp<=width<840vp) 折叠屏
      //  lg:(840vp<=width) 平板
      GridRow({
        columns: {
          // 在不同断点下每行的列数
          xs: 2,
          sm: 3,
          md: 5,
          lg: 7
        },
        // gutter: {
        //   // 主轴间距 交叉轴间距
        //   x: 10,
        //   y: 20
        // }
      }) {
        ForEach(Array.from({ length: 12 }), (item: string, index: number) => {
          GridCol({
            span: {
              // 在不同断点下每列元素所占的列数
              xs: 1,
              sm: 2,
              md: 3,
              lg: 4
            },
            offset: {
              xs: 1,
              sm: 2,
              md: 3,
              lg: 2
            }
          }) {
            Text((index+1).toString())
          }
          .height(100)
          .border({ width: 1, color: Color.Black })
          .backgroundColor(Color.Pink)
        })
      }
      .width('90%')
      .height('90%')
      .border({ width: 1, color: Color.Orange })
      .onBreakpointChange((breakpoints)=> {
        this.currentBreakPoint = breakpoints
      })

      Text(`断点值: ${this.currentBreakPoint}`)
        .fontSize(30)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#dcdfe8')
    .expandSafeArea([SafeAreaType.SYSTEM])
  }
}