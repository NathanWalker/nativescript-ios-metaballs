import { Component, OnInit } from "@angular/core";
import { SegmentedBarItem } from "@nativescript/core";
import {
  SegmentedBar,
  SelectedIndexChangedEventData,
} from "@nativescript/core/ui/segmented-bar";
import {
  registerSwiftUI,
  SwiftUIEventData,
  UIDataDriver,
} from "@nativescript/swift-ui";

declare var MetaBallSingleProvider: any;
declare var MetaBallClubbedProvider: any;
registerSwiftUI(
  "metaballSingle",
  (view) => new UIDataDriver(MetaBallSingleProvider.alloc().init(), view)
);
registerSwiftUI(
  "metaballClubbed",
  (view) => new UIDataDriver(MetaBallClubbedProvider.alloc().init(), view)
);

@Component({
  selector: "ns-home",
  templateUrl: "./home.component.html",
})
export class HomeComponent {
  activeItem: "single" | "clubbed" = "single";
  options: Array<SegmentedBarItem> = [];

  constructor() {
    let item = new SegmentedBarItem();
    item.title = `Metaball`;
    this.options.push(item);

    item = new SegmentedBarItem();
    item.title = `Clubbed`;
    this.options.push(item);
  }

  onSelectedIndexChanged(args: SelectedIndexChangedEventData) {
    this.activeItem = args.newIndex === 1 ? "clubbed" : "single";
  }
}
