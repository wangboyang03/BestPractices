import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { display, window } from '@kit.ArkUI';

const DOMAIN = 0x0000;

export default class PhoneAbility extends UIAbility {
  private currentBreakPoint: string = ''
  private updateBreakpoint(windowWidth: number) :void{
    try {
      //  核心代码1: 将长度的单位由px换算为vp，（px除以像素密度得到vp）
      let windowWidthVp = windowWidth / display.getDefaultDisplaySync().densityPixels
      let newBp: string = ''
      //  核心代码2: 基于窗口宽度vp值，判断当前设备属于哪个断点范围
      if (windowWidthVp < 320) {
        newBp = 'xs'
      } else if (windowWidthVp < 600) {
        newBp = 'sm'
      } else if (windowWidthVp < 840) {
        newBp = 'md'
      } else {
        newBp = 'lg'
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

  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_NOT_SET);
    } catch (err) {
      hilog.error(DOMAIN, 'testTag', 'Failed to set colorMode. Cause: %{public}s', JSON.stringify(err));
    }
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.getMainWindow().then((windowObj) => {
      try {
        // 获取应用启动时的窗口尺寸
        this.updateBreakpoint(windowObj.getWindowProperties().windowRect.width)
        // 注册回调函数，监听窗口尺寸变化
        windowObj.on('windowSizeChange', (windowSize)=>{
          this.updateBreakpoint(windowSize.width)
        })
      }catch (e) {
        // 获取应用启动时的窗口尺寸失败
      }
    }).catch((error: Error)=>{
      // 获取应用启动时的窗口尺寸失败
    })

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN, 'testTag', '%{public}s', 'Ability onBackground');
  }
}