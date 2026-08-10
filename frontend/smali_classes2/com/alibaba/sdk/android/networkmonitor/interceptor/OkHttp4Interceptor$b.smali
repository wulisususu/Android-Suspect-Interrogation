.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$b;
.super Ljava/lang/Object;
.source "OkHttp4Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "b"
.end annotation


# static fields
.field private static a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;-><init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$a;)V

    sput-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;

    return-void
.end method

.method static synthetic a()Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor$b;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp4Interceptor;

    return-object v0
.end method
