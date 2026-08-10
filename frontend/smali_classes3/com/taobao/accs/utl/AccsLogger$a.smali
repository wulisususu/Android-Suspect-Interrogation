.class Lcom/taobao/accs/utl/AccsLogger$a;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/utl/AccsLogger;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# static fields
.field private static final a:Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 10
    new-instance v0, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    const-string v1, "EMASNAccs"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;-><init>(Ljava/lang/String;Z)V

    sput-object v0, Lcom/taobao/accs/utl/AccsLogger$a;->a:Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a()Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;
    .locals 1

    sget-object v0, Lcom/taobao/accs/utl/AccsLogger$a;->a:Lcom/alibaba/sdk/android/logger/BaseSdkLogApi;

    return-object v0
.end method
