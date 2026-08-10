.class public Lcom/alibaba/sdk/android/networkmonitor/f;
.super Lcom/alibaba/sdk/android/networkmonitor/j;
.source "ConnectAcquiredEvent.java"


# instance fields
.field private b:Ljava/lang/String;

.field private c:Ljava/lang/String;


# direct methods
.method public constructor <init>(J)V
    .locals 1

    const-string v0, "connectAcquired"

    .line 1
    invoke-direct {p0, v0, p1, p2}, Lcom/alibaba/sdk/android/networkmonitor/j;-><init>(Ljava/lang/String;J)V

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

    .line 2
    invoke-super {p0}, Lcom/alibaba/sdk/android/networkmonitor/j;->a()Lorg/json/JSONObject;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/f;->b:Ljava/lang/String;

    const-string v2, "url"

    .line 3
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-object v1, p0, Lcom/alibaba/sdk/android/networkmonitor/f;->c:Ljava/lang/String;

    const-string v2, "ip"

    .line 4
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/f;->b:Ljava/lang/String;

    return-void
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/f;->c:Ljava/lang/String;

    return-void
.end method
