describe "FormController/WebViewRow" do
  tests Formotion::FormController

  # By default, `tests` uses @controller.init
  # this isn't ideal for our case, so override.
  def controller
    row_settings = {
      title: "WebView",
      key: :web_view,
      type: :web_view,
      value: "<b>This is a Test</b>"
    }
    @form ||= Formotion::Form.new(
      sections: [{
        rows:[row_settings]
    }])

    @controller ||= Formotion::FormController.alloc.initWithForm(@form)
  end

  def webview_row
    @form.row(:web_view)
  end
  
  it "should only one pin" do
    p annotations
    map_row.object.annotations.size.should == 1
  end

  it "should be a pin at the predefined position" do
    coord = map_row.object.annotations[0].coordinate
    coord.latitude.should == 47.5
    coord.longitude.should == 8.5
  end
  
  it "should set a new pin with new position" do
    map_row.value = CLLocationCoordinate2D.new(48.5, 9.5)
    wait 1 do
      map_row.object.annotations.size.should == 1
      coord = map_row.object.annotations[0].coordinate
      coord.latitude.should == 48.5
      coord.longitude.should == 9.5
    end
  end

end