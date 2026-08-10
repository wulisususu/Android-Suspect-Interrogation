.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$b;
.super Ljava/lang/Object;
.source "OkHttp2Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$a;)V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;

    return-void
.end method

.method static synthetic a()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp2Interceptor;

    return-object v0
.end method
