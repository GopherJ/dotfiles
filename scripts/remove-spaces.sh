
#!/bin/bash

find . -depth -name '*.pdf' \
  | while IFS= read -r f ; do mv -i  "$f" "$(dirname "$f")/$(basename "$f"|tr ' ' _)" ; done

