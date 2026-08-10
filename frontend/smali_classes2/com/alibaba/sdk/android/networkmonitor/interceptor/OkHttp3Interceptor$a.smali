.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor$a;
.super Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;
.source "OkHttp3Interceptor.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/alibaba/sdk/android/networkmonitor/interceptor/c<",
        "Lokhttp3/Call;",
        ">;"
    }
.end annotation


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/OkHttp3Interceptor;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/c;-><init>()V

    return-void
.end method


# virtual methods
.method protected a()Ljava/lang/String;
    .locals 1

    const-string v0, "OkHttp3Interceptor"

    return-object v0
.end method
