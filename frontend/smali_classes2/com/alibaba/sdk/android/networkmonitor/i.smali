.class public Lcom/alibaba/sdk/android/networkmonitor/i;
.super Lcom/alibaba/sdk/android/networkmonitor/e;
.source "ConnectStartEvent.java"


# instance fields
.field private a:Ljava/net/InetSocketAddress;

.field private a:Ljava/net/Proxy;


# direct methods
.method public constructor <init>(J)V
    .locals 1

    const-string v0, "connectStart"

    .line 1
    invoke-direct {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/e;-><init>(Ljava/lang/String;J)V

    return-void
.end method


# virtual methods
.method public a()Lorg/json/JSONObject;
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lorg/json/JSONException;
        }
    .end annotation

    .line 3
    invoke-super {p0}, Lcom/alibaba/sdk/android/networkmonitor/e;->a()Lorg/json/JSONObject;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/i;->a:Ljava/net/InetSocketAddress;

    if-eqz v1, :cond_0

    .line 6
    invoke-virtual {v1}, Ljava/net/InetSocketAddress;->getAddress()Ljava/net/InetAddress;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 8
    invoke-virtual {v1}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1

    const-string v2, "ip"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/i;->a:Ljava/net/Proxy;

    if-eqz v1, :cond_1

    .line 13
    invoke-virtual {v1}, Ljava/net/Proxy;->toString()Ljava/lang/String;

    move-result-object v1

    const-string v2, "proxy"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    return-object v0
.end method

.method public a(Ljava/net/InetSocketAddress;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/i;->a:Ljava/net/InetSocketAddress;

    return-void
.end method

.method public a(Ljava/net/Proxy;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/i;->a:Ljava/net/Proxy;

    return-void
.end method
