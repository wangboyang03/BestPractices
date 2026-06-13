import { display, window } from "@kit.ArkUI"

interface BreakPointTypeOption<T> {
  xs?: T
  sm?: T
  md?: T
  lg?: T
}

export class BreakPointType<T> {
  options: BreakPointTypeOption<T>

  constructor(option: BreakPointTypeOption<T>) {
    this.options = option
  }

  getValue(currentBreakPoint: string) {
    if (currentBreakPoint === 'xs') {
      return this.options.xs
    } else if (currentBreakPoint === 'sm') {
      return this.options.sm
    } else if (currentBreakPoint === 'md') {
      return this.options.md
    } else if (currentBreakPoint === 'lg') {
      return this.options.lg
    } else {
      return undefined
    }
  }
}

export enum BreakPointEnum {
  XS = 'xs',
  SM = 'sm',
  MD = 'md',
  LG = 'lg',
  XL = 'xl',
}

export class ScreenManager {
  context: Context
  currentBreakPoint?: BreakPointEnum

  constructor(mContext: Context) {
    this.context = mContext
  }

  private updateBreakpoint(windowWidth: number) :void{
    try {
      //  核心代码1: 将长度的单位由px换算为vp，（px除以像素密度得到vp）
      let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels
      let newBp: BreakPointEnum = BreakPointEnum.SM
      //  核心代码2: 基于窗口宽度vp值，判断当前设备属于哪个断点范围
      if (windowWidthVp < 320) {
        newBp = BreakPointEnum.XS
      } else if (windowWidthVp < 600) {
        newBp = BreakPointEnum.SM
      } else if (windowWidthVp < 840) {
        newBp = BreakPointEnum.MD
      } else {
        newBp = BreakPointEnum.LG
      }
      if (this.currentBreakPoint !== newBp) {
        this.currentBreakPoint = newBp
        // 核心代码3: 使用状态变量记录当前断点值
        AppStorage.setOrCreate('currentBreakpoint', this.currentBreakPoint)
      }
    } catch(err) {
      console.log("getDisplayByIdSync failed err" + err.code)
    }
  }

  async init() {
    try {
      // 获取窗口并获取窗口宽度 断点信息
      const windowObject = await window.getLastWindow(this.context)
      windowObject.getWindowProperties().windowRect.width
      this.updateBreakpoint(windowObject.getWindowProperties().windowRect.width)
      windowObject.on('windowSizeChange', (windowSize)=>{
        this.updateBreakpoint(windowSize.width)
      })
    } catch (error) {
      console.error(error)
    }
  }

  async off() {
    try {
      const windowObject = await window.getLastWindow(this.context)
      windowObject.off('windowSizeChange')
    } catch (error) {
      console.error(error)
    }
  }
}