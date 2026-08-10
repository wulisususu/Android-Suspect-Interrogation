.class public Lcom/alibaba/sdk/android/networkmonitor/j;
.super Lcom/alibaba/sdk/android/networkmonitor/e;
.source "ConnectionEvent.java"


# instance fields
.field protected a:I


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2, p3}, Lcom/alibaba/sdk/android/networkmonitor/e;-><init>(Ljava/lang/String;J)V

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
    invoke-super {p0}, Lcom/alibaba/sdk/android/networkmonitor/e;->a()Lorg/json/JSONObject;

    move-result-object v0

    iget v1, p0, Lcom/alibaba/sdk/android/networkmonitor/j;->a:I

    const-string v2, "connection"

    .line 3
    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    return-object v0
.end method

.method public a(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/networkmonitor/j;->a:I

    return-void
.end method
