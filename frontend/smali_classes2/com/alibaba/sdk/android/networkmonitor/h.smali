.class public Lcom/alibaba/sdk/android/networkmonitor/h;
.super Lcom/alibaba/sdk/android/networkmonitor/e;
.source "ConnectFailedEvent.java"


# instance fields
.field private a:Ljava/lang/Throwable;

.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;


# direct methods
.method public constructor <init>(J)V
    .locals 1

    const-string v0, "connectFailed"

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

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->b:Ljava/lang/String;

    .line 4
    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->b:Ljava/lang/String;

    const-string v2, "ip"

    .line 5
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->c:Ljava/lang/String;

    const-string v2, "networkProtocolName"

    .line 8
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->a:Ljava/lang/Throwable;

    if-eqz v1, :cond_1

    .line 11
    invoke-virtual {v1}, Ljava/lang/Throwable;->getMessage()Ljava/lang/String;

    move-result-object v1

    const-string v2, "msg"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->b:Ljava/lang/String;

    return-void
.end method

.method public a(Ljava/lang/Throwable;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->a:Ljava/lang/Throwable;

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/h;->c:Ljava/lang/String;

    return-void
.end method
