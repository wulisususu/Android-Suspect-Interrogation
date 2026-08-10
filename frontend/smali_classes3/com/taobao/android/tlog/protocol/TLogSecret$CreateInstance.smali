.class Lcom/taobao/android/tlog/protocol/TLogSecret$CreateInstance;
.super Ljava/lang/Object;
.source "TLogSecret.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/android/tlog/protocol/TLogSecret;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CreateInstance"
.end annotation


# static fields
.field private static instance:Lcom/taobao/android/tlog/protocol/TLogSecret;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 40
    new-instance v0, Lcom/taobao/android/tlog/protocol/TLogSecret;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/taobao/android/tlog/protocol/TLogSecret;-><init>(Lcom/taobao/android/tlog/protocol/TLogSecret$1;)V

    sput-object v0, Lcom/taobao/android/tlog/protocol/TLogSecret$CreateInstance;->instance:Lcom/taobao/android/tlog/protocol/TLogSecret;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 39
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$100()Lcom/taobao/android/tlog/protocol/TLogSecret;
    .locals 1

    sget-object v0, Lcom/taobao/android/tlog/protocol/TLogSecret$CreateInstance;->instance:Lcom/taobao/android/tlog/protocol/TLogSecret;

    return-object v0
.end method
