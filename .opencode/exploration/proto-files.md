# Sapphillon API Proto Files Analysis

## Overview

This document contains a comprehensive analysis of all `.proto` files in the Sapphillon_API project.

**Total proto files found:** 12

### File Structure
```
proto/sapphillon/
├── v1/
│   ├── plugin_service.proto
│   ├── permission.proto
│   ├── plugin.proto
│   ├── version.proto
│   ├── workflow_service.proto
│   └── workflow.proto
├── ai/v1/
│   ├── model_service.proto
│   ├── provider.proto
│   ├── model.proto
│   ├── search_model_service.proto
│   └── provider_service.proto
└── arcana/v1/
    ├── plugin_manifest.proto
    └── package_config.proto
```

---

## Detailed Analysis by File

### 1. proto/sapphillon/v1/plugin_service.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**Service:** `PluginService`
- **Comment:** ✅ YES - "Service for managing plugins. Allows clients to list and query available plugin packages that can be used in workflows."

**RPC Methods:**

1. `ListPlugins(ListPluginsRequest) returns (ListPluginsResponse)`
   - **Comment:** ✅ YES - "Lists all available plugin packages. Returns a paginated list of plugin packages that can be installed or used."

2. `InstallPlugin(InstallPluginRequest) returns (InstallPluginResponse)`
   - **Comment:** ✅ YES - Extensive documentation including:
     - Experimental API notice
     - TODO items (Repository, Checksum, Certificate support)
     - Security considerations (authentication, signature verification, sandboxing)
     - Error conditions (INVALID_ARGUMENT, ALREADY_EXISTS, PERMISSION_DENIED, FAILED_PRECONDITION)

3. `UninstallPlugin(UninstallPluginRequest) returns (UninstallPluginResponse)`
   - **Comment:** ✅ YES - Extensive documentation including:
     - Experimental API notice
     - Security considerations
     - Error conditions (NOT_FOUND, FAILED_PRECONDITION, PERMISSION_DENIED)

**Messages:**

1. `ListPluginsRequest`
   - **Comment:** ✅ YES - "Request message for listing plugins."
   - **Fields:**
     - `page_size` (int32): ✅ Commented - "The maximum number of plugins to return. The service may return fewer than this value. If zero, the server will pick an appropriate default."
     - `page_token` (string): ✅ Commented - "A page token, received from a previous `ListPlugins` call. Provide this to retrieve the subsequent page."

2. `ListPluginsResponse`
   - **Comment:** ✅ YES - "Response message for listing plugins."
   - **Fields:**
     - `plugins` (repeated PluginPackage): ✅ Commented - "A list of available plugin packages."
     - `next_page_token` (string): ✅ Commented - "A token to retrieve the next page of results. If this field is empty, there are no more results."
     - `status` (google.rpc.Status): ❌ No comment

3. `InstallPluginRequest`
   - **Comment:** ✅ YES - "Request message for installing a plugin."
   - **Fields:**
     - `uri` (string): ✅ Commented - Extensive documentation including:
       - Required field notice
       - Security constraints (HTTPS-only, host validation, size limits)
       - Error handling details

4. `InstallPluginResponse`
   - **Comment:** ✅ YES - "Response message for installing a plugin."
   - **Fields:**
     - `plugin` (PluginPackage): ✅ Commented - Documentation on success/failure behavior
     - `status` (google.rpc.Status): ✅ Commented - Documentation on error codes and behavior

5. `UninstallPluginRequest`
   - **Comment:** ✅ YES - "Request message for uninstalling a plugin."
   - **Fields:**
     - `package_id` (string): ✅ Commented - Extensive documentation including:
       - Required field notice
       - Format specifications
       - Error handling details

6. `UninstallPluginResponse`
   - **Comment:** ✅ YES - "Response message for uninstalling a plugin."
   - **Fields:**
     - `status` (google.rpc.Status): ❌ No comment

---

### 2. proto/sapphillon/v1/permission.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**File-level Comments:**
- ✅ YES - "Defines permission primitives used to authorize operations across Sapphillon services."
- ✅ YES - Documentation notes about Google API style, field behavior notes, resource names
- ✅ YES - TODO comment

**Enums:**

1. `PermissionType`
   - **Comment:** ✅ YES - "Enumerates the type of action a permission authorizes." with detailed value descriptions
   - **Values:**
     - `PERMISSION_TYPE_UNSPECIFIED`: ✅ Commented - "Default value. Do not use."
     - `PERMISSION_TYPE_READ`, `PERMISSION_TYPE_WRITE`: ✅ Commented - Reserved for backward compatibility
     - `PERMISSION_TYPE_EXECUTE`: ✅ Commented - "Grants ability to execute or invoke the resource (e.g., run, trigger)."
     - `PERMISSION_TYPE_FILESYSTEM_READ`: ✅ Commented - "Grants read-only access to the file system."
     - `PERMISSION_TYPE_FILESYSTEM_WRITE`: ✅ Commented - "Grants write or modify access to the file system."
     - `PERMISSION_TYPE_NET_ACCESS`: ✅ Commented - "Grants network access."
     - `PERMISSION_TYPE_ALLOW_MCP`: ✅ Commented - "Grants permission to use the MCP AI service."
     - `PERMISSION_TYPE_ALLOW_ALL`: ✅ Commented - "Grants all permissions. Use with caution."

2. `PermissionLevel`
   - **Comment:** ✅ YES - "Indicates the sensitivity or criticality level required for a permission." with detailed value descriptions
   - **Values:**
     - `PERMISSION_LEVEL_UNSPECIFIED`: ✅ Commented - "Default value. Do not use."
     - `PERMISSION_LEVEL_MEDIUM`: ✅ Commented - "Standard operations with moderate impact."
     - `PERMISSION_LEVEL_HIGH`: ✅ Commented - "Operations with elevated risk or broader impact."
     - `PERMISSION_LEVEL_CRITICAL`: ✅ Commented - "Operations that can cause system-wide effects or data loss."

**Messages:**

1. `Permission`
   - **Comment:** ✅ YES - Extensive documentation including:
     - Usage description
     - Field descriptions
     - Example proto snippet
     - Field behavior notes
   - **Fields:**
     - `display_name` (string): ✅ Commented - "Human-readable name of the permission, suitable for display in UIs. Example: "Read File", "Execute Workflow"."
     - `description` (string): ✅ Commented - "Detailed description of what the permission allows and when it is used. Keep concise but informative for reviewers and users."
     - `permission_type` (PermissionType): ✅ Commented - "The action category this permission authorizes. Behavior: Required."
     - `resource` (repeated string): ✅ Commented - "Resource identifiers this permission applies to. Format: Free-form strings in v1 (e.g., "file.txt", "workflows/etl_daily", "buckets/logs"). Behavior: Optional. If empty, applies broadly and should be used with caution. Example: ["projects/proj-123/locations/us/workflows/etl_daily"]"
     - `permission_level` (PermissionLevel): ✅ Commented - "The sensitivity or criticality level associated with this permission. Behavior: Recommended. Some approval flows may require a minimum level."

2. `AllowedPermission`
   - **Comment:** ✅ YES - Extensive documentation including:
     - Purpose description
     - Field descriptions
     - Usage notes
   - **Fields:**
     - `plugin_function_id` (string): ✅ Commented - "Identifier of the plugin function this permission set applies to. This must correspond to a function exposed by one of the plugin packages listed in WorkflowCode.plugin_packages or to a function id present in WorkflowCode.plugin_function_ids."
     - `permissions` (repeated Permission): ✅ Commented - "Permissions that are allowed when invoking the specified plugin function. Prefer specific Permission.resource and Permission.action combinations to minimize scope. Example: ..."

---

### 3. proto/sapphillon/v1/plugin.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**Messages:**

1. `FunctionParameter`
   - **Comment:** ✅ YES - "Represents a single parameter (argument or return value) of a function. Stores the variable name, type, and description similar to JSDoc @param or @returns."
   - **Fields:**
     - `name` (string): ✅ Commented - "The variable name of the parameter. Example: "userId", "message", "options"."
     - `type` (string): ✅ Commented - "The type of the parameter. Example: "string", "number", "boolean", "object", "Array<string>"."
     - `description` (string): ✅ Commented - "A short description of what the parameter represents."

2. `FunctionDefine`
   - **Comment:** ✅ YES - "Represents the function definition including JSDoc-style documentation. Stores the function parameters and return value information."
   - **Fields:**
     - `parameters` (repeated FunctionParameter): ✅ Commented - "The list of function parameters (arguments). Order should match the function signature."
     - `returns` (repeated FunctionParameter): ✅ Commented - "The return value(s) information. Optional: may be empty for void functions. Multiple return values are supported (e.g., for tuple-like returns)."

3. `PluginFunction`
   - **Comment:** ✅ YES - "Describes a callable function exposed by a plugin. A function declares its purpose, identity, and required permissions for execution."
   - **Fields:**
     - `function_id` (string): ✅ Commented - Extensive documentation including behavior, format, uniqueness
     - `function_name` (string): ✅ Commented - "Human-friendly display name of the function. Example: "Send Notification"."
     - `description` (string): ✅ Commented - "Short description of what the function does and when to use it."
     - `permissions` (repeated Permission): ✅ Commented - "Permissions required to execute this function successfully. Use Permission.resource to scope to specific entities as needed."
     - `arguments`, `returns`: ✅ Commented - Reserved for backward compatibility
     - `function_define` (FunctionDefine): ✅ Commented - "JSDoc-style function definition with parameters and return value. Contains structured information about function arguments and return type."
     - `version` (string): ✅ Commented - Extensive documentation including behavior, format, uniqueness, default behavior

4. `PluginPackage`
   - **Comment:** ✅ YES - "Represents a plugin package that can be installed into the platform. A plugin groups one or more functions and includes metadata useful for discovery and governance."
   - **Fields:**
     - `package_id` (string): ✅ Commented - "Stable unique identifier for the plugin package. Behavior: Required; unique across all installed plugins. Format: Pure package name only (e.g. "sapphillon")."
     - `package_name` (string): ✅ Commented - "Human-friendly name of the plugin package. Example: "Notifications"."
     - `package_version` (string): ✅ Commented - "Semantic version of the plugin package. Format: "MAJOR.MINOR.PATCH" (e.g., "1.0.3")."
     - `description` (string): ✅ Commented - "Description of the plugin's purpose and capabilities."
     - `functions` (repeated PluginFunction): ✅ Commented - "Functions exposed by this plugin."
     - `plugin_store_url` (string): ✅ Commented - "URL to the plugin's store page or documentation. Example: "https://plugins.example.com/com.example.notifications"."
     - `internal_plugin` (optional bool): ✅ Commented - "Whether this plugin is intended for internal use only. Behavior: Optional. Defaults to false when unset."
     - `verified` (optional bool): ✅ Commented - "Whether this plugin has been verified by the platform or publisher. Behavior: Optional. Defaults to false when unset."
     - `deprecated` (optional bool): ✅ Commented - "Whether this plugin is deprecated. New usage should be avoided. Behavior: Optional. When true, UIs should display warnings."
     - `installed_at` (google.protobuf.Timestamp): ✅ Commented - "Time when the plugin was installed."
     - `updated_at` (google.protobuf.Timestamp): ✅ Commented - "Time when the plugin metadata or package was last updated."
     - `provider_id` (string): ✅ Commented - Extensive documentation including behavior, format, relationship to package_id, note about AI provider distinction

---

### 4. proto/sapphillon/v1/version.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**Service:** `VersionService`
- **Comment:** ✅ YES - "Provides read-only application version information. The service returns semantic version strings for display and compatibility checks."

**RPC Methods:**

1. `GetVersion(GetVersionRequest) returns (GetVersionResponse)`
   - **Comment:** ✅ YES - Documentation including:
     - Behavior notes (Unary RPC, fast and side-effect free)
     - Usage scenarios (health checks, compatibility gating)
     - Error conditions

**Messages:**

1. `Version`
   - **Comment:** ✅ YES - "Represents application version information. The version string typically follows Semantic Versioning."
   - **Fields:**
     - `version` (string): ✅ Commented - "The version of the application. Format: "vMAJOR.MINOR.PATCH" with optional pre-release or build metadata (e.g., "v1.2.3", "v1.2.3-alpha-1", "v1.2.3-beta.1")."

2. `GetVersionRequest`
   - **Comment:** ✅ YES - "Request for GetVersion. This message is intentionally empty to allow future extensibility without breaking changes."
   - **Fields:** None (empty message)

3. `GetVersionResponse`
   - **Comment:** ✅ YES - "Response for GetVersion."
   - **Fields:**
     - `version` (Version): ✅ Commented - "The current application version."

---

### 5. proto/sapphillon/v1/workflow_service.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**Service:** `WorkflowService`
- **Comment:** ✅ YES - "Generates and fixes structured workflow definitions from natural language descriptions. Methods stream partial outputs to allow progressive rendering in UIs and long-running processing."

**RPC Methods:**

1. `GenerateWorkflow(GenerateWorkflowRequest) returns (stream GenerateWorkflowResponse)`
   - **Comment:** ✅ YES - Documentation including:
     - Behavior notes (server-streaming RPC)
     - Response format description
     - Error conditions

2. `FixWorkflow(FixWorkflowRequest) returns (stream FixWorkflowResponse)`
   - **Comment:** ✅ YES - Documentation including:
     - Behavior notes (server-streaming RPC)
     - Response format description
     - Error conditions

3. `RunWorkflow(RunWorkflowRequest) returns (RunWorkflowResponse)`
   - **Comment:** ❌ No comment

4. `GetWorkflow(GetWorkflowRequest) returns (GetWorkflowResponse)`
   - **Comment:** ❌ No comment

5. `ListWorkflows(ListWorkflowsRequest) returns (ListWorkflowsResponse)`
   - **Comment:** ❌ No comment

6. `UpdateWorkflow(UpdateWorkflowRequest) returns (UpdateWorkflowResponse)`
   - **Comment:** ❌ No comment

7. `DeleteWorkflow(DeleteWorkflowRequest) returns (DeleteWorkflowResponse)`
   - **Comment:** ❌ No comment

**Messages:**

1. `GenerateWorkflowRequest`
   - **Comment:** ✅ YES - "Request to generate a workflow from a natural language prompt."
   - **Fields:**
     - `prompt` (string): ✅ Commented - "Natural language prompt describing the desired workflow. Example: "Check the weather, and if it's raining, send me a notification." Behavior: Required; must be non-empty."
     - `model_name` (string): ✅ Commented - "The name of the model to use for generation. Format: "models/{model_id}" Behavior: Optional; if not specified, the default model will be used."

2. `GenerateWorkflowResponse`
   - **Comment:** ✅ YES - "Server-streamed response containing the generated workflow definition. Each streamed message may be partial; the client should merge or replace as appropriate."
   - **Fields:**
     - `workflow_definition` (sapphillon.v1.Workflow): ✅ Commented - "Structured workflow definition."
     - `status` (google.rpc.Status): ✅ Commented - "The status of the response. If the status is not OK, it indicates an error."

3. `FixWorkflowRequest`
   - **Comment:** ✅ YES - "Request to fix a workflow definition using a problem description."
   - **Fields:**
     - `workflow_definition` (string): ✅ Commented - "The workflow definition to be fixed. Format: JSON, YAML, or another structured text representation. Behavior: Required; must be parseable by the service."
     - `description` (string): ✅ Commented - "Description of issues to fix or constraints to apply. Example: "Step IDs must be unique; add retry to notification step." Behavior: Required; must be non-empty."

4. `FixWorkflowResponse`
   - **Comment:** ✅ YES - "Server-streamed response carrying fixed workflow definitions and a change summary. The final message typically represents the complete fixed definition."
   - **Fields:**
     - `fixed_workflow_definition` (sapphillon.v1.Workflow): ✅ Commented - "The fixed workflow definition."
     - `change_summary` (string): ✅ Commented - "Summary of changes applied to produce the fixed definition. Example: "Renamed duplicate step IDs; added retry policy to 'notify'."
     - `status` (google.rpc.Status): ✅ Commented - "The status of the response. If the status is not OK, it indicates an error."

5. `RunWorkflowRequest`
   - **Comment:** ❌ No comment
   - **Fields:**
     - `by_id` (WorkflowSourceById): ❌ No comment
     - `workflow_definition`: ✅ Commented - Reserved
     - `ai_model_name` (optional string): ✅ Commented - "Optional AI model name to use for this run. If not specified, the default model will be used. The name should match a model from `sapphillon.ai.v1.Models.name`."

6. `WorkflowSourceById`
   - **Comment:** ✅ YES - "Specifies a workflow to run using its ID and code ID."
   - **Fields:**
     - `workflow_id` (string): ✅ Commented - "The ID of the workflow to run."
     - `workflow_code_id` (string): ✅ Commented - "The ID of the workflow code to run."

7. `RunWorkflowResponse`
   - **Comment:** ✅ YES - "Response after running a workflow. Contains the result of the workflow execution and status."
   - **Fields:**
     - `workflow_result` (sapphillon.v1.WorkflowResult): ✅ Commented - "The result of the workflow execution."
     - `status` (google.rpc.Status): ✅ Commented - "The status of the response. If the status is not OK, it indicates an error."

8. `GetWorkflowRequest`
   - **Comment:** ❌ No comment
   - **Fields:**
     - `workflow_id` (string): ❌ No comment

9. `GetWorkflowResponse`
   - **Comment:** ❌ No comment
   - **Fields:**
     - `workflow` (Workflow): ❌ No comment
     - `status` (google.rpc.Status): ❌ No comment

10. `ListWorkflowsFilter`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `display_name` (string): ❌ No comment
      - `workflow_language` (sapphillon.v1.WorkflowLanguage): ❌ No comment

11. `OrderByDirection` (Enum)
    - **Comment:** ✅ YES - "Sort direction"
    - **Values:**
      - `ORDER_BY_DIRECTION_UNSPECIFIED`: ❌ No comment
      - `ORDER_BY_DIRECTION_ASC`: ✅ Commented - "Ascending"
      - `ORDER_BY_DIRECTION_DESC`: ✅ Commented - "Descending"

12. `OrderByClause`
    - **Comment:** ✅ YES - "Order by clause"
    - **Fields:**
      - `field` (string): ✅ Commented - "Field name to order by (e.g. "display_name", "updated_at")"
      - `direction` (OrderByDirection): ❌ No comment

13. `ListWorkflowsRequest`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `page_size` (int32): ❌ No comment
      - `page_token` (string): ❌ No comment
      - `filter` (ListWorkflowsFilter): ❌ No comment
      - `order_by` (repeated OrderByClause): ❌ No comment

14. `ListWorkflowsResponse`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `workflows` (repeated Workflow): ❌ No comment
      - `next_page_token` (string): ❌ No comment
      - `status` (google.rpc.Status): ❌ No comment

15. `UpdateWorkflowRequest`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `workflow` (Workflow): ❌ No comment
      - `update_mask` (google.protobuf.FieldMask): ❌ No comment

16. `UpdateWorkflowResponse`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `workflow` (Workflow): ❌ No comment
      - `status` (google.rpc.Status): ❌ No comment

17. `DeleteWorkflowRequest`
    - **Comment:** ❌ No comment
    - **Fields:**
      - `workflow_id` (string): ❌ No comment

18. `DeleteWorkflowResponse`
    - **Comment:** ❌ No comment
    - **Fields:** None (empty message)

---

### 6. proto/sapphillon/v1/workflow.proto

**Package:** `sapphillon.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**Enums:**

1. `WorkflowLanguage`
   - **Comment:** ✅ YES - "Enumerates supported workflow source languages. Used to indicate the language of WorkflowCode.code."
   - **Values:**
     - `WORKFLOW_LANGUAGE_UNSPECIFIED`: ✅ Commented - "Default value. Do not use."
     - `WORKFLOW_LANGUAGE_TYPESCRIPT`: ✅ Commented - "TypeScript source code."
     - `WORKFLOW_LANGUAGE_JAVASCRIPT`: ✅ Commented - "JavaScript source code."

**Messages:**

1. `WorkflowCode`
   - **Comment:** ✅ YES - "Represents a specific revision of workflow source code and metadata."
   - **Fields:**
     - `id` (string): ✅ Commented - "Stable identifier of the workflow code entity. Format: UUID."
     - `code_revision` (int32): ✅ Commented - "Monotonic integer representing the code version within the workflow. Behavior: Required. Starts at 1 and increments with each change."
     - `code` (string): ✅ Commented - "The workflow source code."
     - `language` (WorkflowLanguage): ✅ Commented - "The programming language of the source code."
     - `created_at` (google.protobuf.Timestamp): ✅ Commented - "Creation time of this code revision."
     - `result` (repeated WorkflowResult): ✅ Commented - "Optional result previews or cached outputs associated with this code revision. Behavior: Optional. May be empty when no run has occurred. Can store multiple results."
     - `required_permissions`: ✅ Commented - Reserved
     - `plugin_packages` (repeated sapphillon.v1.PluginPackage): ✅ Commented - "Plugin packages that this workflow code depends on. This allows the workflow to use functions defined in these plugins."
     - `plugin_function_ids` (repeated string): ✅ Commented - "Plugin functions that this workflow code directly uses."
     - `allowed_permissions` (repeated AllowedPermission): ✅ Commented - "Allowed permissions for this workflow code."

2. `WorkflowResultType` (Enum)
   - **Comment:** ✅ YES - "Classifies the outcome of a workflow execution."
   - **Values:**
     - `WORKFLOW_RESULT_TYPE_SUCCESS_UNSPECIFIED`: ✅ Commented - "Execution completed successfully."
     - `WORKFLOW_RESULT_TYPE_FAILURE`: ✅ Commented - "Execution failed (see exit_code and description)."

3. `WorkflowResult`
   - **Comment:** ✅ YES - "Captures the result of running a workflow at a specific code revision."
   - **Fields:**
     - `id` (string): ✅ Commented - "Identifier of the result record. Format: UUID."
     - `display_name` (string): ✅ Commented - "Human-friendly name for display."
     - `description` (string): ✅ Commented - "Summary of the execution and relevant details."
     - `result` (string): ✅ Commented - "Raw result payload or textual summary of the run."
     - `ran_at` (google.protobuf.Timestamp): ✅ Commented - "Time the execution completed."
     - `result_type` (WorkflowResultType): ✅ Commented - "Success or failure classification."
     - `exit_code` (int32): ✅ Commented - "Process exit code when applicable (0 for success)."
     - `workflow_code_revision`: ✅ Commented - Reserved
     - `workflow_result_revision` (int32): ✅ Commented - "Monotonic revision of this result record."

4. `Workflow`
   - **Comment:** ✅ YES - "Represents a workflow entity including its code history and execution results."
   - **Fields:**
     - `id` (string): ✅ Commented - "Stable identifier for the workflow. Format: UUID."
     - `display_name` (string): ✅ Commented - "Human-readable name for the workflow."
     - `description` (string): ✅ Commented - "Description of the workflow's purpose and behavior."
     - `workflow_language` (WorkflowLanguage): ✅ Commented - "Preferred or primary language used by this workflow."
     - `workflow_code` (repeated WorkflowCode): ✅ Commented - "History of workflow code revisions."
     - `created_at` (google.protobuf.Timestamp): ✅ Commented - "Creation time of the workflow."
     - `updated_at` (google.protobuf.Timestamp): ✅ Commented - "Last update time of the workflow."
     - `workflow_results` (repeated WorkflowResult): ✅ Commented - "Historical execution results for this workflow."

---

### 7. proto/sapphillon/ai/v1/model_service.proto

**Package:** `sapphillon.ai.v1`

**File Header:**
- None (no copyright/license header)

**Service:** `ModelService`
- **Comment:** ✅ YES (Javadoc style) - "Service for managing LLM models. Allows clients to configure, list, update, and remove different LLM models that the system can use."

**RPC Methods:**

1. `CreateModel(CreateModelRequest) returns (CreateModelResponse)`
   - **Comment:** ✅ YES - "Creates a new model configuration. Returns the created model resource."

2. `GetModel(GetModelRequest) returns (GetModelResponse)`
   - **Comment:** ✅ YES - "Retrieves a specific model's details by its resource name."

3. `ListModels(ListModelsRequest) returns (ListModelsResponse)`
   - **Comment:** ✅ YES - "Lists all configured models."

4. `UpdateModel(UpdateModelRequest) returns (UpdateModelResponse)`
   - **Comment:** ✅ YES - "Updates a model's configuration. Use a field_mask to specify which fields to update."

5. `DeleteModel(DeleteModelRequest) returns (DeleteModelResponse)`
   - **Comment:** ✅ YES - "Deletes a model configuration permanently."

**Messages:**

1. `CreateModelRequest`
   - **Comment:** ✅ YES - "Request message for creating a model."
   - **Fields:**
     - `model` (Models): ✅ Commented - "The model resource to create. The `name` field should be left empty; the server will assign it."

2. `CreateModelResponse`
   - **Comment:** ✅ YES - "Response message for creating a model."
   - **Fields:**
     - `model` (Models): ❌ No comment
     - `status` (google.rpc.Status): ❌ No comment

3. `GetModelRequest`
   - **Comment:** ✅ YES - "Request message for retrieving a model."
   - **Fields:**
     - `name` (string): ✅ Commented - "The resource name of the model to retrieve. Format: "models/{model_id}""

4. `GetModelResponse`
   - **Comment:** ✅ YES - "Response message for retrieving a model."
   - **Fields:**
     - `model` (Models): ❌ No comment
     - `status` (google.rpc.Status): ❌ No comment

5. `ListModelsRequest`
   - **Comment:** ✅ YES - "Request message for listing models."
   - **Fields:**
     - `page_size` (int32): ✅ Commented - "The maximum number of models to return."
     - `page_token` (string): ✅ Commented - "A page token, received from a previous `ListModels` call."

6. `ListModelsResponse`
   - **Comment:** ✅ YES - "Response message for listing models."
   - **Fields:**
     - `models` (repeated Models): ✅ Commented - "A list of configured models."
     - `next_page_token` (string): ✅ Commented - "A token to retrieve the next page of results."
     - `status` (google.rpc.Status): ❌ No comment

7. `UpdateModelRequest`
   - **Comment:** ✅ YES - "Request message for updating a model."
   - **Fields:**
     - `model` (Models): ✅ Commented - "The model resource with updated fields. The `name` field is used to identify the model to update."
     - `update_mask` (google.protobuf.FieldMask): ✅ Commented - "The list of fields to be updated."

8. `UpdateModelResponse`
   - **Comment:** ✅ YES - "Response message for updating a model."
   - **Fields:**
     - `model` (Models): ❌ No comment
     - `status` (google.rpc.Status): ❌ No comment

9. `DeleteModelRequest`
   - **Comment:** ✅ YES - "Request message for deleting a model."
   - **Fields:**
     - `name` (string): ✅ Commented - "The resource name of the model to delete. Format: "models/{model_id}""

10. `DeleteModelResponse`
    - **Comment:** ✅ YES - "Response message for deleting a model."
    - **Fields:**
      - `status` (google.rpc.Status): ❌ No comment

---

### 8. proto/sapphillon/ai/v1/provider.proto

**Package:** `sapphillon.ai.v1`

**File Header:**
- None (no copyright/license header)

**Message:** `Provider`
- **Comment:** ✅ YES - "Provider represents a configured Large Language Model provider. It holds the necessary information to interact with a specific LLM, such as its name and API key."
- **Fields:**
  - `name` (string): ✅ Commented - "The unique resource name of the provider. Format: "providers/{provider_id}" The {provider_id} is a unique identifier for the provider."
  - `display_name` (string): ✅ Commented - "A user-friendly display name for the provider. e.g., "My Local Model""
  - `api_key` (string): ✅ Commented - "The API key for authenticating with the provider. This field is sensitive and should be handled securely. It will be write-only (never returned in a Get or List request)."
  - `api_endpoint` (string): ✅ Commented - "The API endpoint for the provider. This is the URL where requests should be sent to interact with the LLM."

---

### 9. proto/sapphillon/ai/v1/model.proto

**Package:** `sapphillon.ai.v1`

**File Header:**
- None (no copyright/license header)

**Message:** `Models`
- **Comment:** ✅ YES - "Models represents a configured Large Language Model."
- **Fields:**
  - `name` (string): ✅ Commented - "The unique resource name of the model. Format: "models/{model_id}" The {model_id} is a unique identifier for the model."
  - `display_name` (string): ✅ Commented - "A user-friendly display name for the model. e.g., "My Local Model""
  - `description` (optional string): ✅ Commented - "A description of the model. Optional field to provide additional context about the model."
  - `provider`: ✅ Commented - Reserved
  - `provider_name` (string): ✅ Commented - "The name of the provider associated with this model."
  - `priority` (optional uint32): ✅ Commented - "The priority of the model. Higher numbers indicate higher priority. This value is used to order models when multiple models are eligible for selection, such as when listing available models or choosing a default model for a request. Clients may treat 0 as the lowest priority and use larger values for models that should be preferred. When multiple models share the same priority, their relative order is not guaranteed and may be determined by other factors (for example, name or provider)."

---

### 10. proto/sapphillon/ai/v1/search_model_service.proto

**Package:** `sapphillon.ai.v1`

**File Header:**
- None (no copyright/license header)

**Service:** `SearchModelService`
- **Comment:** ❌ No comment

**RPC Methods:**

1. `SearchModel(SearchModelRequest) returns (SearchModelResponse)`
   - **Comment:** ✅ YES - "Searches for models based on the provided query. Returns a list of models that match the search criteria."

**Messages:**

1. `SearchModelRequest`
   - **Comment:** ❌ No comment
   - **Fields:**
     - `provider_name_query` (optional string): ❌ No comment
     - `model_name_query` (optional string): ❌ No comment
     - `page_size` (int32): ✅ Commented - "The maximum number of results to return."
     - `page_token` (string): ✅ Commented - "The page token for pagination."

2. `SearchModelResponse`
   - **Comment:** ❌ No comment
   - **Fields:**
     - `models` (repeated sapphillon.ai.v1.Models): ✅ Commented - "The list of models matching the search criteria."
     - `next_page_token` (string): ✅ Commented - "The token to retrieve the next page of results."
     - `status` (google.rpc.Status): ❌ No comment

---

### 11. proto/sapphillon/arcana/v1/plugin_manifest.proto

**Package:** `sapphillon.arcana.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**File-level Comments:**
- ✅ YES - "Defines the PluginManifest schema — the runtime metadata embedded into package.js."
- ✅ YES - Detailed explanation of the build-time process (static package configuration merged with dynamic JSDoc extraction)

**Messages:**

1. `IODefinition`
   - **Comment:** ✅ YES - "Represents a single input/output variable definition, analogous to JSDoc @param or @returns tags."
   - **Fields:**
     - `type` (string): ✅ Commented - "The data type of the variable. Format: TypeScript/JavaScript type expression (e.g., "string", "number", "boolean", "object", "Array<string>"). Example: "string"."
     - `name` (string): ✅ Commented - "The variable name of the parameter or return value. Example: "userId", "message", "options"."
     - `description` (string): ✅ Commented - "A short description of what the variable represents."

2. `Params`
   - **Comment:** ✅ YES - "Wraps an IODefinition to represent a single function parameter (argument)."
   - **Fields:**
     - `io_definition` (IODefinition): ✅ Commented - "The I/O definition describing this parameter's type, name, and description."

3. `Return`
   - **Comment:** ✅ YES - "Wraps an IODefinition to represent a single function return value."
   - **Fields:**
     - `io_definition` (IODefinition): ✅ Commented - "The I/O definition describing this return value's type, name, and description."

4. `FunctionDefinition`
   - **Comment:** ✅ YES - "Represents a single function exposed by the plugin, including JSDoc-extracted metadata such as permissions, parameters, and return values."
   - **Fields:**
     - `name` (string): ✅ Commented - "The name of the function. Behavior: Required. Must be unique within the plugin package. Used as the stable identifier for invoking the function at runtime. Example: "sendNotification"."
     - `description` (string): ✅ Commented - "A short description of what the function does and when to use it."
     - `permissions` (repeated sapphillon.v1.Permission): ✅ Commented - "The permissions required to execute this function. Behavior: Extracted from JSDoc @permission tags at build time. Must match the permission whitelist (FileSystemRead, FileSystemWrite, Net, Run, Env). Validated during static analysis (sapphillon-cli check)."
     - `params` (repeated Params): ✅ Commented - "The function parameters (arguments), in declaration order. Behavior: Extracted from JSDoc @param tags."
     - `returns` (repeated Return): ✅ Commented - "The function return values. Behavior: Extracted from JSDoc @returns tags. May be empty for void functions."

5. `PluginManifest`
   - **Comment:** ✅ YES - "The complete runtime metadata embedded into package.js at build time."
   - **Fields:**
     - `package_config` (PackageConfig): ✅ Commented - "The static package configuration sourced from package.toml. See PackageConfig."
     - `functions` (repeated FunctionDefinition): ✅ Commented - "The functions exposed by this plugin. Behavior: Extracted from JSDoc at build time and merged with the static configuration to form the complete manifest."

---

### 12. proto/sapphillon/arcana/v1/package_config.proto

**Package:** `sapphillon.arcana.v1`

**File Header:**
- Copyright: 2025 Yuta Takahashi
- License: Apache License 2.0

**File-level Comments:**
- ✅ YES - "Defines the package.toml schema for developer input configuration."
- ✅ YES - Documentation about SSOT (Single Source of Truth) and auto-generation of JSON Schema and TypeScript types

**Messages:**

1. `PackageToml`
   - **Comment:** ✅ YES - "Root structure of the package.toml file. Wraps the package configuration and declares the API (schema) version the package targets."
   - **Fields:**
     - `package` (PackageConfig): ✅ Commented - "The package configuration block. See PackageConfig for details."
     - `api_version` (string): ✅ Commented - "The Arcana ecosystem API version this package targets. Used by the toolchain to enforce compatibility checks. Behavior: Packages built for incompatible API versions may be rejected. Format: Kubernetes-style version string — "vMAJOR" with an optional stability suffix: "alphaN" or "betaN" (e.g., "v1", "v1alpha1", "v2beta3"). Example: "v1"."

2. `PackageConfig`
   - **Comment:** ✅ YES - "Holds the static metadata for a plugin package as authored by the developer in package.toml."
   - **Fields:**
     - `id` (string): ✅ Commented - "The stable unique identifier of the package. Behavior: Required. Must be unique within a repository. Immutable once registered. Format: Lowercase, hyphen-separated identifier (e.g., "my-awesome-plugin"). Example: "my-awesome-plugin"."
     - `name` (string): ✅ Commented - "The human-friendly display name of the package. Example: "My Awesome Plugin"."
     - `version` (string): ✅ Commented - "The semantic version of the package. Format: Semantic Versioning "MAJOR.MINOR.PATCH" (e.g., "1.0.0", "2.1.3-beta.1"). Behavior: Once registered in a repository, a (id, version) pair is immutable and cannot be overwritten. Example: "1.0.0"."
     - `description` (string): ✅ Commented - "A short summary of the package's purpose and capabilities."
     - `author_github_id` (repeated string): ✅ Commented - "The list of GitHub user IDs of the package authors/owners. Behavior: At least one is recommended. Used for ownership attribution and may be cross-referenced with the developer's Minisign public key during verification. Example: ["alice", "bob"]."
     - `tags` (repeated string): ✅ Commented - "The list of tags for categorization and discoverability. Example: ["automation", "utility", "ai"]."
     - `homepage_url` (optional string): ✅ Commented - "Optional URL to the package's homepage, documentation, or source repository. Behavior: Optional. If omitted, no homepage is linked. Example: "https://github.com/user/my-plugin"."

---

## Documentation Coverage Summary

### By Package

#### sapphillon.v1 (6 files)
1. **plugin_service.proto** - ✅ **Excellent** - Well-documented with extensive security and error handling notes
2. **permission.proto** - ✅ **Excellent** - Comprehensive documentation with examples and behavior notes
3. **plugin.proto** - ✅ **Excellent** - Well-documented with examples and detailed field descriptions
4. **version.proto** - ✅ **Good** - Basic documentation present, adequate for simple service
5. **workflow_service.proto** - ⚠️ **Mixed** - First 2 RPCs well-documented, remaining 5 have no comments; some messages undocumented
6. **workflow.proto** - ✅ **Excellent** - Well-documented with detailed field descriptions

#### sapphillon.ai.v1 (5 files)
1. **model_service.proto** - ✅ **Good** - Service and RPCs documented, some response message fields missing comments
2. **provider.proto** - ✅ **Good** - Message and all fields documented
3. **model.proto** - ✅ **Good** - Message and all fields documented
4. **search_model_service.proto** - ⚠️ **Poor** - Service has no comment; request/response messages missing comments
5. **provider_service.proto** - ✅ **Good** - Service and RPCs documented, some request/response fields missing comments

#### sapphillon.arcana.v1 (2 files)
1. **plugin_manifest.proto** - ✅ **Excellent** - Comprehensive documentation with build-time process explanation
2. **package_config.proto** - ✅ **Excellent** - Well-documented with SSOT notes and detailed field descriptions

### Documentation Quality Categories

#### ✅ Excellent (100% coverage, detailed comments):
- plugin_service.proto
- permission.proto
- plugin.proto
- workflow.proto
- plugin_manifest.proto
- package_config.proto

#### ✅ Good (80-99% coverage, minor gaps):
- version.proto
- provider.proto
- model.proto
- model_service.proto
- provider_service.proto

#### ⚠️ Mixed/Incomplete (50-79% coverage):
- workflow_service.proto
- search_model_service.proto

### Missing Copyright/License Headers
The following files do not have the standard copyright/license header:
- model_service.proto
- provider.proto
- model.proto
- search_model_service.proto
- provider_service.proto

---

## Key Findings

1. **Consistent Documentation Pattern**: The v1 and arcana.v1 packages follow Google API style guidelines with comprehensive documentation.

2. **Inconsistency in AI v1 Package**: The AI-related protos (sapphillon.ai.v1) lack the standard copyright/license headers present in other packages.

3. **Incomplete Documentation in workflow_service.proto**: This file has several RPC methods without any comments, and many request/response messages are undocumented.

4. **Security Awareness**: The plugin_service.proto includes extensive security considerations, error conditions, and TODO items, showing security-first design.

5. **Build-Time Metadata**: The arcana package clearly documents the build-time process for merging static configuration with dynamic JSDoc extraction.

6. **Reserved Fields**: Several files use `reserved` keywords to maintain backward compatibility while evolving the schema.

7. **Behavior Documentation**: Most well-documented files include "Behavior:" notes that describe required/optional fields, formats, and implementation expectations.

8. **Examples**: Many files include proto snippet examples to illustrate usage patterns.

9. **TODO Comments**: permission.proto includes TODO comments for future enhancement.

10. **Cross-References**: Several files reference other messages/services using proper proto import syntax.
