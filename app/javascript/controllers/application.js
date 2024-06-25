import { Application } from "@hotwired/stimulus";
// コンポーネントを読み込むための記述
import { Autocomplete } from "stimulus-autocomplete";

const application = Application.start();
// コンポーネントにあるAutocompleteコントローラを使用するための記述
application.register("autocomplete", Autocomplete);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
