@Entry
@Component
struct DisplayCase {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Image($r("sys.media.waveform_folder_fill"))
        .width(100)
        .aspectRatio(1)

      Image($r("sys.media.rectangle_filled_and_line_horizontal_and_rectangle"))
        .width(100)
        .aspectRatio(1)

      Image($r("sys.media.ohos_user_auth_icon_face"))
        .width(100)
        .aspectRatio(1)

      Image($r("sys.media.phone_arrow_down_left_circle_fill"))
        .width(100)
        .aspectRatio(1)

      Image($r("sys.media.ohos_save_button_filled"))
        .width(100)
        .aspectRatio(1)
    }
    .justifyContent(FlexAlign.SpaceEvenly)
    .height('100%')
    .width('100%')
  }
}