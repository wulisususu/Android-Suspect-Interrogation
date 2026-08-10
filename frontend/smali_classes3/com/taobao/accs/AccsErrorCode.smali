.class public Lcom/taobao/accs/AccsErrorCode;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field public static final APPKEY_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final APPSECRET_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final APP_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final DM_APPKEY_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final DM_DEVICEID_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final DM_PACKAGENAME_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final DM_TAIR_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final ERROR_SHOULD_NEVER_HAPPEN:Lcom/alibaba/sdk/android/error/ErrorCode;

.field private static final HTTP_CODE_DM_APP_KEY_INVALID:I = 0x12f

.field private static final HTTP_CODE_DM_DEVICE_ID_INVALID:I = 0x12e

.field private static final HTTP_CODE_DM_PACKAGE_NAME_INVALID:I = 0x130

.field private static final HTTP_CODE_DM_TAIR_ERROR:I = 0x66

.field private static final HTTP_CODE_SUCCESS:I = 0xc8

.field public static final INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final MESSAGE_HOST_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final MESSAGE_QUEUE_FULL:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final MESSAGE_TOO_LARGE:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORKSDK_SPDY_CLOSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORKSDK_SPDY_RES_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORK_INAPP_ARGS_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORK_INAPP_CONNECT_FAIL:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORK_INAPP_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORK_INAPP_NO_STRATEGY:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NETWORK_INAPP_TIMEOUT:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final PARAMETER_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final REQ_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final RESPONSE_PARSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SEND_LOCAL_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SERVER_UNKNOWN_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SERVIER_HIGH_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SERVIER_HIGH_LIMIT_BRUSH:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SERVIER_LOW_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SPDY_AUTH_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SPDY_AUTH_PARAM_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SPDY_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SPDY_PING_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

.field public static final codes:[Lcom/alibaba/sdk/android/error/ErrorCode;

.field private static final define:Lcom/alibaba/sdk/android/error/ErrorDefine;


# direct methods
.method static constructor <clinit>()V
    .locals 37

    .line 22
    new-instance v0, Lcom/alibaba/sdk/android/error/ErrorDefine;

    new-instance v1, Lcom/alibaba/sdk/android/error/IntCodeGenerator;

    invoke-direct {v1}, Lcom/alibaba/sdk/android/error/IntCodeGenerator;-><init>()V

    const-string v2, "EACCS"

    invoke-direct {v0, v2, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;-><init>(Ljava/lang/String;Lcom/alibaba/sdk/android/error/CodeGenerator;)V

    sput-object v0, Lcom/taobao/accs/AccsErrorCode;->define:Lcom/alibaba/sdk/android/error/ErrorDefine;

    const-string v1, "200"

    .line 24
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    const-string v2, "\u6210\u529f"

    .line 25
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v1

    .line 26
    invoke-virtual {v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v1

    sput-object v1, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v2, "300"

    .line 28
    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string v3, "\u901a\u9053\u672a\u5efa\u7acb"

    .line 29
    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    const-string v3, "\u8bf7\u5148\u521d\u59cb\u5316\uff0cbindApp\uff0c\u518d\u8c03\u7528\u5176\u5b83api"

    .line 30
    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v2

    .line 31
    invoke-virtual {v2}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v2

    sput-object v2, Lcom/taobao/accs/AccsErrorCode;->APP_NOT_BIND:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v3, "-1"

    .line 34
    invoke-virtual {v0, v3}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    const-string v4, "\u9759\u9ed8\u8fde\u63a5\u4e2d\u65ad\uff0c\u65e0\u6cd5\u53d1\u9001\u6d88\u606f"

    .line 35
    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    const-string v4, "\u5185\u90e8\u4f1a\u91cd\u8bd5\uff0c\u5982\u679c\u4e00\u76f4\u5931\u8d25\uff0c\u9700\u8981\u6392\u67e5\u4e0b\u9759\u9ed8\u901a\u9053\u662f\u5426\u6b63\u5e38"

    .line 36
    invoke-virtual {v3, v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v3

    .line 37
    invoke-virtual {v3}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v3

    sput-object v3, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v4, "-2"

    .line 39
    invoke-virtual {v0, v4}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string v5, "\u53c2\u6570\u9519\u8bef,\u53d1\u9001\u7684msg\u4e3anull"

    .line 40
    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    const-string v5, "\u8bf7\u68c0\u67e5\u53d1\u8d77\u8bf7\u6c42\u7684\u53c2\u6570\u662f\u5426\u6b63\u786e"

    .line 41
    invoke-virtual {v4, v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v4

    .line 42
    invoke-virtual {v4}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v4

    sput-object v4, Lcom/taobao/accs/AccsErrorCode;->PARAMETER_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v5, "-3"

    .line 44
    invoke-virtual {v0, v5}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v6, "\u670d\u52a1\u8fd4\u56de\u6570\u636e\u5f02\u5e38"

    .line 45
    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    const-string v6, "\u8bf7\u5173\u6ce8\u9519\u8bef\u4fe1\u606f\u4e2d\u7684\u670d\u52a1\u8fd4\u56de\u6570\u636e\uff0c\u5e76\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301\u540c\u5b66\u786e\u8ba4\u539f\u56e0"

    .line 46
    invoke-virtual {v5, v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v5

    .line 47
    invoke-virtual {v5}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v5

    sput-object v5, Lcom/taobao/accs/AccsErrorCode;->RESPONSE_PARSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v6, "-4"

    .line 49
    invoke-virtual {v0, v6}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    const-string v7, "\u5355\u6b21\u53d1\u9001\u6570\u636e\u8fc7\u5927"

    .line 50
    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    const-string v7, "\u8bf7\u51cf\u5c11\u4e00\u6b21\u53d1\u9001\u7684\u6570\u636e\u91cf\uff0c\u5c01\u88c5\u4e4b\u540e\u603b\u7684\u6570\u636e\u91cf\u8981\u5c0f\u4e8e16KB"

    .line 51
    invoke-virtual {v6, v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v6

    .line 52
    invoke-virtual {v6}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v6

    sput-object v6, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_TOO_LARGE:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v7, "-5"

    .line 54
    invoke-virtual {v0, v7}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    const-string v8, "\u53d1\u9001\u670d\u52a1\u5730\u5740\u4e3anull"

    .line 55
    invoke-virtual {v7, v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    const-string v8, "\u8bf7\u68c0\u67e5\u4e0b\u521d\u59cb\u5316\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    .line 56
    invoke-virtual {v7, v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v7

    .line 57
    invoke-virtual {v7}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v7

    sput-object v7, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_HOST_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v8, "-6"

    .line 59
    invoke-virtual {v0, v8}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    const-string v9, "\u9759\u9ed8\u901a\u9053\u957f\u8fde\u63a5\u8ba4\u8bc1\u53c2\u6570\u9519\u8bef"

    .line 60
    invoke-virtual {v8, v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    const-string v9, "\u8bf7\u68c0\u67e5\u521d\u59cb\u5316\u53c2\u6570\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    .line 61
    invoke-virtual {v8, v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v8

    .line 62
    invoke-virtual {v8}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v8

    sput-object v8, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_PARAM_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v9, "-7"

    .line 64
    invoke-virtual {v0, v9}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v9

    const-string v10, "\u9759\u9ed8\u901a\u9053\u957f\u8fde\u63a5\u8ba4\u8bc1\u5f02\u5e38"

    .line 65
    invoke-virtual {v9, v10}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v9

    const-string v10, "\u8bf7\u67e5\u770b\u9519\u8bef\u4fe1\u606f\uff0c\u786e\u8ba4\u5177\u4f53\u5f02\u5e38\u4fe1\u606f"

    .line 66
    invoke-virtual {v9, v10}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v9

    .line 67
    invoke-virtual {v9}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v9

    sput-object v9, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v11, "-8"

    .line 69
    invoke-virtual {v0, v11}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    const-string v12, "\u53d1\u9001\u6570\u636e\u5f02\u5e38"

    .line 70
    invoke-virtual {v11, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    .line 71
    invoke-virtual {v11, v10}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v10

    .line 72
    invoke-virtual {v10}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v10

    sput-object v10, Lcom/taobao/accs/AccsErrorCode;->SEND_LOCAL_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v11, "-9"

    .line 74
    invoke-virtual {v0, v11}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    const-string v12, "\u53d1\u9001\u6d88\u606f\u8d85\u65f6"

    .line 75
    invoke-virtual {v11, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    const-string v12, "\u9700\u8981\u7ed3\u5408\u5177\u4f53\u662f\u67e5\u770b\u4e3a\u4ec0\u4e48\u8d85\u65f6"

    .line 76
    invoke-virtual {v11, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v11

    .line 77
    invoke-virtual {v11}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v11

    sput-object v11, Lcom/taobao/accs/AccsErrorCode;->REQ_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v12, "-10"

    .line 79
    invoke-virtual {v0, v12}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    const-string v13, "\u9759\u9ed8\u901a\u9053\u957f\u8fde\u63a5\u65ad\u8fde"

    .line 80
    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    const-string v13, "\u65ad\u8fde\u9700\u8981\u67e5\u770b\u4e4b\u524d\u7684\u65e5\u5fd7"

    .line 81
    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 82
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->SPDY_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "-11"

    .line 84
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u5e94\u7528\u5185\u957f\u8fde\u63a5\u65ad\u5f00"

    .line 85
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u4e00\u822c\u4e3a\u957f\u8fde\u63a5\u5efa\u8fde\u5931\u8d25\u9020\u6210\uff0c\u9700\u8981\u770b\u65e5\u5fd7\u5206\u6790"

    .line 86
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 87
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-12"

    .line 89
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "\u9759\u9ed8\u901a\u9053\u957f\u8fde\u63a5ping\u8d85\u65f6"

    .line 90
    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    .line 91
    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/taobao/accs/AccsErrorCode;->SPDY_PING_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "-13"

    .line 93
    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v16, v14

    const-string v14, "\u65e0\u7f51\u7edc"

    .line 94
    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "\u8bf7\u68c0\u67e5\u7f51\u7edc\u8fde\u63a5"

    .line 95
    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    .line 96
    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/taobao/accs/AccsErrorCode;->NO_NETWORK:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v15, "-14"

    .line 98
    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v15

    move-object/from16 v17, v14

    const-string v14, "appKey\u4e0d\u5b58\u5728"

    .line 99
    invoke-virtual {v15, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "\u8bf7\u68c0\u67e5\u521d\u59cb\u5316\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    .line 100
    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    .line 101
    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/taobao/accs/AccsErrorCode;->APPKEY_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    move-object/from16 v18, v14

    const-string v14, "-15"

    .line 103
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v19, v13

    const-string v13, "appSecret\u4e0d\u5b58\u5728"

    .line 104
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 105
    invoke-virtual {v13, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 106
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->APPSECRET_NULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "70008"

    .line 108
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v20, v13

    const-string v13, "\u957f\u8fde\u63a5\u53d1\u9001\u961f\u5217\u5df2\u6ee1"

    .line 109
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u786e\u8ba4\u662f\u5426\u6709\u9ad8\u5e76\u53d1\u53d1\u9001\u6d88\u606f\uff0c\u5982\u679c\u6709\uff0c\u8bf7\u9650\u5236\u53d1\u9001\u9891\u6b21"

    .line 110
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 111
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->MESSAGE_QUEUE_FULL:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "70020"

    .line 113
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v21, v13

    const-string v13, "\u4f4e\u7ea7\u522b\u9650\u6d41"

    .line 114
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u548c\u90e8\u7f72\u540c\u5b66\u786e\u8ba4\u9650\u6d41\u7b56\u7565"

    .line 115
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 116
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->SERVIER_LOW_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

    move-object/from16 v22, v13

    const-string v13, "70021"

    .line 118
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    move-object/from16 v23, v12

    const-string v12, "\u9ad8\u7ea7\u522b\u9650\u6d41,\u4e0d\u53d1\u9001"

    .line 119
    invoke-virtual {v13, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 120
    invoke-virtual {v12, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 121
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->SERVIER_HIGH_LIMIT:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "70023"

    .line 123
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    move-object/from16 v24, v12

    const-string v12, "\u9632\u5237\u89e3\u5c01\u540e\u89e6\u53d1\u7684\u9650\u6d41\uff0c\u4e0d\u53d1\u9001"

    .line 124
    invoke-virtual {v13, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 125
    invoke-virtual {v12, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 126
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->SERVIER_HIGH_LIMIT_BRUSH:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "102"

    .line 128
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bbe\u5907\u65e0\u6548"

    .line 129
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    move-object/from16 v25, v12

    const-string v12, "\u5982\u679c\u662f\u6d4b\u8bd5\u65f6\u53d1\u73b0\u7684\uff0c\u8bf7\u6e05\u9664\u5e94\u7528\u6570\u636e\u91cd\u65b0\u5c1d\u8bd5"

    .line 130
    invoke-virtual {v13, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 131
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->DM_TAIR_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    move-object/from16 v26, v13

    const-string v13, "302"

    .line 133
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 134
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 135
    invoke-virtual {v13, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 136
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->DM_DEVICEID_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "303"

    .line 138
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "appkey\u914d\u7f6e\u9519\u8bef"

    .line 139
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u68c0\u67e5appKey\u914d\u7f6e\u662f\u5426\u6b63\u786e"

    .line 140
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 141
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->DM_APPKEY_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "304"

    .line 143
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v27, v13

    const-string v13, "\u5305\u540d\u9519\u8bef"

    .line 144
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u68c0\u67e5appKey\u548c\u5e94\u7528\u5305\u540d\u662f\u5426\u5339\u914d"

    .line 145
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 146
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->DM_PACKAGENAME_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-20"

    .line 148
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineServerError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v28, v13

    const-string v13, "\u670d\u52a1\u8fd4\u56de\u9519\u8bef"

    .line 149
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u5173\u6ce8\u4e0b\u9519\u8bef\u4fe1\u606f\u4e2d\u7684\u670d\u52a1\u8fd4\u56de\u7684\u9519\u8bef\u7801\uff0c\u5e76\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301\u540c\u5b66\u786e\u8ba4\u539f\u56e0"

    .line 150
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 151
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->SERVER_UNKNOWN_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-22"

    .line 153
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v29, v13

    const-string v13, "\u5e95\u5c42sdk\u8fde\u63a5\u5173\u95ed"

    .line 154
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u5173\u6ce8\u4e0b\u9519\u8bef\u4fe1\u606f\u4e2d\u7684\u5e95\u5c42sdk\u8fd4\u56de\u7684\u9519\u8bef\u4fe1\u606f\uff0c\u5e76\u8054\u7cfb\u963f\u91cc\u4e91\u6280\u672f\u652f\u6301\u540c\u5b66\u786e\u8ba4\u539f\u56e0"

    .line 155
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 156
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_CLOSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    move-object/from16 v30, v13

    const-string v13, "-23"

    .line 158
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    move-object/from16 v31, v12

    const-string v12, "\u53d1\u9001\u6570\u636e\u8fd4\u56de\u9519\u8bef"

    .line 159
    invoke-virtual {v13, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 160
    invoke-virtual {v12, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 161
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_RES_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "-25"

    .line 163
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u4e0d\u5e94\u8be5\u53d1\u751f\u7684\u9519\u8bef"

    .line 164
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    const-string v14, "\u8bf7\u5173\u6ce8\u4e0b\u9519\u8bef\u4fe1\u606f\uff0c\u68c0\u67e5\u521d\u59cb\u5316\u662f\u5426\u5b58\u5728\u9519\u8bef"

    .line 165
    invoke-virtual {v13, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 166
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->ERROR_SHOULD_NEVER_HAPPEN:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-26"

    .line 168
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v32, v13

    const-string v13, "\u5efa\u8fde\u53c2\u6570\u9519\u8bef"

    .line 169
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 170
    invoke-virtual {v13, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v13

    .line 171
    invoke-virtual {v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v13

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_ARGS_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-27"

    .line 173
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "\u5efa\u8fde\u8d85\u65f6"

    .line 174
    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    const-string v15, "\u8bf7\u67e5\u770b\u5177\u4f53\u9519\u8bef\u4fe1\u606f\u6392\u67e5"

    .line 175
    invoke-virtual {v14, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v33, v13

    const-string v13, "\u8bf7\u68c0\u67e5\u7f51\u7edc\u662f\u5426\u6b63\u5e38"

    .line 176
    invoke-virtual {v14, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    .line 177
    invoke-virtual {v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v14

    sput-object v14, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_TIMEOUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    move-object/from16 v34, v14

    const-string v14, "-28"

    .line 179
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v35, v12

    const-string v12, "\u5efa\u8fde\u5931\u8d25"

    .line 180
    invoke-virtual {v14, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 181
    invoke-virtual {v12, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 182
    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 183
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_CONNECT_FAIL:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v14, "-29"

    .line 185
    invoke-virtual {v0, v14}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v14

    move-object/from16 v36, v12

    const-string v12, "\u8fde\u63a5\u5730\u5740\u4e0d\u5b58\u5728"

    .line 186
    invoke-virtual {v14, v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    const-string v14, "\u5f53\u524d\u7f51\u7edc\u4e0b\u65e0\u6cd5\u89e3\u6790\u957f\u94fe\u63a5\u5730\u5740"

    .line 187
    invoke-virtual {v12, v14}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 188
    invoke-virtual {v12, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v12

    .line 189
    invoke-virtual {v12}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v12

    sput-object v12, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_NO_STRATEGY:Lcom/alibaba/sdk/android/error/ErrorCode;

    const-string v13, "-30"

    .line 190
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string v13, "\u5efa\u8fde\u5f02\u5e38"

    .line 191
    invoke-virtual {v0, v13}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 192
    invoke-virtual {v0, v15}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 193
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    const/16 v13, 0x23

    new-array v13, v13, [Lcom/alibaba/sdk/android/error/ErrorCode;

    const/4 v14, 0x0

    aput-object v1, v13, v14

    const/4 v1, 0x1

    aput-object v2, v13, v1

    const/4 v1, 0x2

    aput-object v3, v13, v1

    const/4 v1, 0x3

    aput-object v4, v13, v1

    const/4 v1, 0x4

    aput-object v5, v13, v1

    const/4 v1, 0x5

    aput-object v6, v13, v1

    const/4 v1, 0x6

    aput-object v7, v13, v1

    const/4 v1, 0x7

    aput-object v8, v13, v1

    const/16 v1, 0x8

    aput-object v9, v13, v1

    const/16 v1, 0x9

    aput-object v10, v13, v1

    const/16 v1, 0xa

    aput-object v11, v13, v1

    const/16 v1, 0xb

    aput-object v23, v13, v1

    const/16 v1, 0xc

    aput-object v19, v13, v1

    const/16 v1, 0xd

    aput-object v16, v13, v1

    const/16 v1, 0xe

    aput-object v17, v13, v1

    const/16 v1, 0xf

    aput-object v18, v13, v1

    const/16 v1, 0x10

    aput-object v20, v13, v1

    const/16 v1, 0x11

    aput-object v21, v13, v1

    const/16 v1, 0x12

    aput-object v22, v13, v1

    const/16 v1, 0x13

    aput-object v24, v13, v1

    const/16 v1, 0x14

    aput-object v25, v13, v1

    const/16 v1, 0x15

    aput-object v26, v13, v1

    const/16 v1, 0x16

    aput-object v31, v13, v1

    const/16 v1, 0x17

    aput-object v27, v13, v1

    const/16 v1, 0x18

    aput-object v28, v13, v1

    const/16 v1, 0x19

    aput-object v29, v13, v1

    const/16 v1, 0x1a

    aput-object v30, v13, v1

    const/16 v1, 0x1b

    aput-object v35, v13, v1

    const/16 v1, 0x1c

    aput-object v32, v13, v1

    const/16 v1, 0x1d

    aput-object v33, v13, v1

    const/16 v1, 0x1e

    aput-object v34, v13, v1

    const/16 v1, 0x1f

    aput-object v36, v13, v1

    const/16 v1, 0x20

    aput-object v12, v13, v1

    const/16 v1, 0x21

    aput-object v0, v13, v1

    const-string v0, "\u5e95\u5c42\u7f51\u7edc\u5e93\u4fe1\u606f"

    .line 217
    invoke-static {v14, v0}, Lcom/taobao/accs/AccsErrorCode;->convertNetworkSdkError(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    const-string v1, "\u5c0f\u4e8e-10000\u65f6\uff0c\u52a0\u4e0a10000\u662f\u5e95\u5c42\u7f51\u7edc\u5e93\u5bf9\u5e94\u7684\u9519\u8bef\u7801\uff0c\u8bf7\u63a5\u53e3\u5e95\u5c42\u7f51\u7edc\u5e93\u9519\u8bef\u7801\u4fe1\u606f\u6392\u67e5"

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->solution(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    .line 218
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object v0

    const/16 v1, 0x22

    aput-object v0, v13, v1

    sput-object v13, Lcom/taobao/accs/AccsErrorCode;->codes:[Lcom/alibaba/sdk/android/error/ErrorCode;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static addThrowableInfo(Ljava/lang/StringBuilder;Ljava/lang/Throwable;)Ljava/lang/StringBuilder;
    .locals 6

    .line 287
    :goto_0
    invoke-virtual {p1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x9

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 288
    invoke-virtual {p1}, Ljava/lang/Throwable;->getStackTrace()[Ljava/lang/StackTraceElement;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 289
    array-length v2, v0

    if-lez v2, :cond_2

    const/4 v2, 0x0

    .line 290
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "."

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v2, v0, v2

    invoke-virtual {v2}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v3, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    .line 291
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    const/4 v2, 0x1

    .line 292
    :goto_1
    array-length v3, v0

    if-ge v2, v3, :cond_2

    .line 293
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "com.taobao"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    aget-object v3, v0, v2

    .line 294
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "com.aliyun"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    aget-object v3, v0, v2

    .line 295
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "org.android.agoo"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_1

    aget-object v3, v0, v2

    .line 296
    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    const-string v5, "org.alibaba"

    invoke-virtual {v3, v5}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    goto :goto_2

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 297
    :cond_1
    :goto_2
    aget-object v3, v0, v2

    invoke-virtual {v3}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {p0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v0, v2

    .line 298
    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v4

    .line 297
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "("

    .line 299
    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v4, v0, v2

    invoke-virtual {v4}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    aget-object v0, v0, v2

    .line 300
    invoke-virtual {v0}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v0

    .line 299
    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v2, ")"

    .line 300
    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 305
    :cond_2
    invoke-virtual {p1}, Ljava/lang/Throwable;->getCause()Ljava/lang/Throwable;

    move-result-object p1

    if-eqz p1, :cond_3

    const-string v0, "caused by "

    .line 307
    invoke-virtual {p0, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    goto/16 :goto_0

    :cond_3
    return-object p0
.end method

.method public static convertNetworkSdkError(ILjava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;
    .locals 1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->define:Lcom/alibaba/sdk/android/error/ErrorDefine;

    add-int/lit16 p0, p0, -0x2710

    .line 197
    invoke-static {p0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorDefine;->defineSdkError(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0, p1}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->msg(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    return-object p0
.end method

.method public static getAllDetails(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 273
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "["

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-static {}, Lcom/taobao/accs/AccsState;->getInstance()Lcom/taobao/accs/AccsState;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/accs/AccsState;->getState()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 274
    invoke-static {}, Lcom/taobao/accs/utl/i;->a()Lcom/taobao/accs/utl/i;

    move-result-object v2

    invoke-virtual {v2}, Lcom/taobao/accs/utl/i;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    .line 275
    invoke-static {}, Lanet/channel/GlobalAppRuntimeInfo;->isAppBackground()Z

    move-result v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static getExceptionInfo(Ljava/lang/Throwable;)Ljava/lang/String;
    .locals 1

    if-nez p0, :cond_0

    const-string p0, "throwable null"

    return-object p0

    .line 282
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {v0, p0}, Lcom/taobao/accs/AccsErrorCode;->addThrowableInfo(Ljava/lang/StringBuilder;Ljava/lang/Throwable;)Ljava/lang/StringBuilder;

    move-result-object p0

    .line 283
    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method public static isChannelError(I)Z
    .locals 1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SPDY_CONNECTION_DISCONNECTED_WHEN_SEND_DATA:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 254
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_PARAM_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 255
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SPDY_AUTH_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 256
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->REQ_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 257
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SPDY_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 258
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->INAPP_CON_DISCONNECTED:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 259
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SPDY_PING_TIME_OUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 260
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORKSDK_SPDY_CLOSE_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 261
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_ARGS_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 262
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_TIMEOUT:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 263
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_CONNECT_FAIL:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 264
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_NO_STRATEGY:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 265
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-eq p0, v0, :cond_1

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->NETWORK_INAPP_EXCEPTION:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 266
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->getCodeInt()I

    move-result v0

    if-ne p0, v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method

.method public static parseHttpCode(I)Lcom/alibaba/sdk/android/error/ErrorCode;
    .locals 3

    const/16 v0, 0x66

    if-eq p0, v0, :cond_1

    const/16 v0, 0xc8

    if-eq p0, v0, :cond_0

    packed-switch p0, :pswitch_data_0

    sget-object v0, Lcom/taobao/accs/AccsErrorCode;->SERVER_UNKNOWN_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    .line 242
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/error/ErrorCode;->copy()Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "code:"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p0

    invoke-virtual {p0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, p0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->detail(Ljava/lang/String;)Lcom/alibaba/sdk/android/error/ErrorBuilder;

    move-result-object p0

    invoke-virtual {p0}, Lcom/alibaba/sdk/android/error/ErrorBuilder;->build()Lcom/alibaba/sdk/android/error/ErrorCode;

    move-result-object p0

    return-object p0

    :pswitch_0
    sget-object p0, Lcom/taobao/accs/AccsErrorCode;->DM_PACKAGENAME_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :pswitch_1
    sget-object p0, Lcom/taobao/accs/AccsErrorCode;->DM_APPKEY_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :pswitch_2
    sget-object p0, Lcom/taobao/accs/AccsErrorCode;->DM_DEVICEID_INVALID:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :cond_0
    sget-object p0, Lcom/taobao/accs/AccsErrorCode;->SUCCESS:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :cond_1
    sget-object p0, Lcom/taobao/accs/AccsErrorCode;->DM_TAIR_ERROR:Lcom/alibaba/sdk/android/error/ErrorCode;

    return-object p0

    :pswitch_data_0
    .packed-switch 0x12e
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public static printErrorCode()V
    .locals 4

    .line 222
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    .line 223
    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "ACCS\u9519\u8bef\u7801\uff0c\u4e00\u5171"

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    sget-object v2, Lcom/taobao/accs/AccsErrorCode;->codes:[Lcom/alibaba/sdk/android/error/ErrorCode;

    array-length v3, v2

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v3, "\u4e2a"

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v3, 0xa

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 224
    invoke-static {}, Lcom/alibaba/sdk/android/error/ErrorCode;->docTitle()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 225
    invoke-static {v2}, Lcom/alibaba/sdk/android/error/ErrorCode;->docContent([Lcom/alibaba/sdk/android/error/ErrorCode;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "ACCS_ERROR_CODE"

    .line 226
    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v0}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
