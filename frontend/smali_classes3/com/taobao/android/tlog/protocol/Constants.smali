.class public Lcom/taobao/android/tlog/protocol/Constants;
.super Ljava/lang/Object;
.source "Constants.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/android/tlog/protocol/Constants$AndroidJointPointKey;,
        Lcom/taobao/android/tlog/protocol/Constants$DevicePropertyKey;
    }
.end annotation


# static fields
.field public static final KEY_APP_BUILD:Ljava/lang/String; = "appBuild"

.field public static final KEY_CLIENT_EVENT_QUEUE:Ljava/lang/String; = "clientEventQueue"

.field public static final KEY_FILE_NAME:Ljava/lang/String; = "fileName"

.field public static final KEY_FILE_URL:Ljava/lang/String; = "tfsPath"

.field public static final KEY_STAT_DATA:Ljava/lang/String; = "statData"

.field public static final RESPONSE_CODE_FAIL_OTHER:I = 0x7

.field public static final RESPONSE_CODE_FILE_UPLOAD_FAILED:I = 0x6

.field public static final RESPONSE_CODE_FILE_UPLOAD_SUCCESS:I = 0x5

.field public static final RESPONSE_CODE_NEW_COMMAND:I = 0x2

.field public static final RESPONSE_CODE_SUCCESS_OTHER:I = 0x0

.field public static final appIdName:Ljava/lang/String; = "X-Rdwp-App-Id"

.field public static final appKeyName:Ljava/lang/String; = "X-Rdwp-App-Key"

.field public static final deviceIdName:Ljava/lang/String; = "X-Rdwp-Device-Id"

.field public static final opCodeName:Ljava/lang/String; = "X-Rdwp-Op-Code"

.field public static final replyCode:Ljava/lang/String; = "X-Rdwp-Reply-Code"

.field public static final replyIdName:Ljava/lang/String; = "X-Rdwp-Reply-Id"

.field public static final replyMsg:Ljava/lang/String; = "X-Rdwp-Reply-Message"

.field public static final requestIdName:Ljava/lang/String; = "X-Rdwp-Request-Id"

.field public static final sessionIdName:Ljava/lang/String; = "X-Rdwp-Session-Id"

.field public static final type:Ljava/lang/String; = "type"

.field public static final version:Ljava/lang/Integer;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x1

    .line 26
    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    sput-object v0, Lcom/taobao/android/tlog/protocol/Constants;->version:Ljava/lang/Integer;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
