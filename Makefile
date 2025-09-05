# Copyright 2025 Yuta Takahashi
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.PHONY: buf_check_style, buf_fix_style, buf_debug

buf_check_style:
	@echo "Check Protocol Buffer Style"
	@echo "----------------------------------------------------------"
	buf lint proto || true
	@echo "----------------------------------------------------------"
	buf format proto -d || true

buf_fix_style:
	@echo "Fix Protocol Buffer Style"
	@echo "----------------------------------------------------------"
	buf format proto -w
	@echo "----------------------------------------------------------"

buf_debug:
	@echo "Debug Protocol Buffer"
	@proto_files=$$(find proto -name '*.proto' | tr '\n' ' '); \
	if [ -z "$$proto_files" ]; then \
		echo "No .proto files found in proto/"; \
		exit 1; \
	fi; \
	evans --proto $$proto_files repl

