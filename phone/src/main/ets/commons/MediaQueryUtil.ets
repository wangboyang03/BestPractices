import mediaQuery from '@ohos.mediaquery'

interface Breakpoint {
  name: string
  maxSize: number
  mediaQueryListener?: mediaQuery.MediaQueryListener
}

export class MediaQueryUtil {
  private currentBreakpoint: string = 'md'
  private breakpoints: Breakpoint[] = [
    { name: 'xs', maxSize: 0 },
    { name: 'sm', maxSize: 320 },
    { name: 'md', maxSize: 600 },
    { name: 'lg', maxSize: 840 },
    { name: 'xl', maxSize: 1440 }
  ]

  /**
   * 注册监听
   * @param mUIContext
   */
  register(mUIContext: UIContext) {
    this.breakpoints.forEach((breakpoint: Breakpoint, index) => {
      let condition: string // 条件
      if (index == this.breakpoints.length - 1) {
        // 此时认为是最后一个断点了
        condition = '(' + breakpoint.maxSize + 'vp<=width' + ')' // (1440vp<=width)
      } else {
        // 其他断点 (0vp<=width<320vp)
        condition = '(' + breakpoint.maxSize + 'vp<=width<' + this.breakpoints[index + 1].maxSize + 'vp)'
      }
      breakpoint.mediaQueryListener = mUIContext.getMediaQuery().matchMediaSync(condition)
      breakpoint.mediaQueryListener.on('change', (mediaQueryResult) => {
        if (!!mediaQueryResult.matches) {
          this.updateMediaQuery(breakpoint.name)
        }
      })
    })
  }

  /**
   * 取消监听
   */
  unregister() {
    this.breakpoints.forEach((breakpoint: Breakpoint) => {
      if (breakpoint.mediaQueryListener) {
        breakpoint.mediaQueryListener.off('change')
      }
    })
  }

  /**
   * 更新媒体查询
   * @param breakpoint
   */
  updateMediaQuery(breakpoint: string) {
    if (this.currentBreakpoint != breakpoint) {
      this.currentBreakpoint = breakpoint
      AppStorage.set<string>('currentBreakpoint', this.currentBreakpoint) // 保存当前断点
    }
  }
}