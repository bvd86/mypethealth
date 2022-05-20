import { Controller } from "@hotwired/stimulus";
import $ from "jquery";
import "select2";
import 'select2/dist/css/select2.min.css';

export default class extends Controller {
  connect() {
    $(this.element).select2({
      width: "100%",
      placeholder: "If you are a vet, what is your specialty?"
    });

    // Fixing auto focus on the select2 field
    $(document).on('select2:open', () => {
      document.querySelector('.select2-search__field').focus();
    });
  }
}
