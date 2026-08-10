.class Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;
.super Ljava/lang/Object;
.source "InterceptorHelper.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;Ljava/net/InetSocketAddress;Ljava/net/Proxy;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/net/InetSocketAddress;

.field final synthetic a:Ljava/net/Proxy;


# direct methods
.method constructor <init>(Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;Ljava/lang/Object;JLjava/net/InetSocketAddress;Ljava/net/Proxy;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iput-object p2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/lang/Object;

    iput-wide p3, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:J

    iput-object p5, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/InetSocketAddress;

    iput-object p6, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/Proxy;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/lang/Object;

    .line 1
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a(Ljava/lang/Object;)Lcom/alibaba/sdk/android/networkmonitor/a;

    move-result-object v0

    if-eqz v0, :cond_3

    iget-wide v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:J

    .line 3
    invoke-virtual {v0, v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/a;->c(J)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/InetSocketAddress;

    if-eqz v1, :cond_0

    .line 5
    invoke-virtual {v1}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 7
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->b(Ljava/lang/String;)V

    .line 11
    :cond_0
    new-instance v1, Lcom/alibaba/sdk/android/networkmonitor/i;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:J

    invoke-direct {v1, v2, v3}, Lcom/alibaba/sdk/android/networkmonitor/i;-><init>(J)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/InetSocketAddress;

    .line 12
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/i;->a(Ljava/net/InetSocketAddress;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/Proxy;

    .line 13
    invoke-virtual {v1, v2}, Lcom/alibaba/sdk/android/networkmonitor/i;->a(Ljava/net/Proxy;)V

    .line 14
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/a;->a(Lcom/alibaba/sdk/android/networkmonitor/e;)V

    iget-object v0, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;

    .line 16
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a;->a()Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    const-string v2, "connectStart: call = "

    invoke-direct {v1, v2}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/lang/Object;

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", inetSocketAddress = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/InetSocketAddress;

    const-string v3, "null"

    if-nez v2, :cond_1

    move-object v2, v3

    goto :goto_0

    .line 17
    :cond_1
    invoke-virtual {v2}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v2

    :goto_0
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ", proxy = "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/alibaba/sdk/android/networkmonitor/interceptor/a$x;->a:Ljava/net/Proxy;

    if-nez v2, :cond_2

    goto :goto_1

    .line 18
    :cond_2
    invoke-virtual {v2}, Ljava/net/Proxy;->toString()Ljava/lang/String;

    move-result-object v3

    :goto_1
    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    .line 19
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/networkmonitor/utils/c;->a(Ljava/lang/String;Ljava/lang/String;)V

    :cond_3
    return-void
.end method
