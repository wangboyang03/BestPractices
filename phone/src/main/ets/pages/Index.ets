import mediaquery from '@ohos.mediaquery';
import { MediaQueryUtil } from '../commons/MediaQueryUtil';

@Entry
@Component
struct Index {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  mediaQueryUtil?: MediaQueryUtil;

  aboutToAppear(): void {
    this.mediaQueryUtil = new MediaQueryUtil();
    this.mediaQueryUtil.register(this.getUIContext());
  }

  aboutToDisappear(): void {
    this.mediaQueryUtil?.unregister();
  }

  build() {
    Flex({justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center}) {
      Text(this.currentBreakpoint).fontSize(50).fontWeight(FontWeight.Medium)
    }
    .width(200)
    .height(200)
  }
}