.class public Lcom/alibaba/sdk/android/settingservice/b/b;
.super Ljava/lang/Object;


# instance fields
.field a:Ljava/lang/String;

.field public b:J

.field public c:Lorg/json/JSONObject;

.field public d:J

.field private e:I


# direct methods
.method public constructor <init>(Ljava/lang/String;I)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    iput-wide v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->d:J

    iput-object p1, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->a:Ljava/lang/String;

    iput p2, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->e:I

    return-void
.end method

.method public static a(Lorg/json/JSONObject;)Lcom/alibaba/sdk/android/settingservice/b/b;
    .locals 7

    const/4 v0, 0x0

    if-nez p0, :cond_0

    return-object v0

    :cond_0
    const-string v1, "service"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "ttl"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v2

    const-string v4, "conf"

    invoke-virtual {p0, v4}, Lorg/json/JSONObject;->optJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v4

    const-string v5, "startTime"

    invoke-virtual {p0, v5}, Lorg/json/JSONObject;->optLong(Ljava/lang/String;)J

    move-result-wide v5

    invoke-static {v1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_1

    return-object v0

    :cond_1
    new-instance p0, Lcom/alibaba/sdk/android/settingservice/b/b;

    const/4 v0, 0x1

    invoke-direct {p0, v1, v0}, Lcom/alibaba/sdk/android/settingservice/b/b;-><init>(Ljava/lang/String;I)V

    iput-wide v2, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    iput-object v4, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    iput-wide v5, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->d:J

    return-object p0
.end method


# virtual methods
.method public a()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->a:Ljava/lang/String;

    return-object v0
.end method

.method public b()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->e:I

    return v0
.end method

.method public c()Lorg/json/JSONObject;
    .locals 6

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    iget-object v0, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->a:Ljava/lang/String;

    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    :try_start_0
    const-string v2, "service"

    iget-object v3, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->a:Ljava/lang/String;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v2, "ttl"

    iget-wide v3, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->b:J

    invoke-virtual {v0, v2, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v2, "conf"

    iget-object v3, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->c:Lorg/json/JSONObject;

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    iget-wide v2, p0, Lcom/alibaba/sdk/android/settingservice/b/b;->d:J

    const-wide/16 v4, 0x0

    cmp-long v4, v2, v4

    if-lez v4, :cond_1

    const-string v4, "startTime"

    invoke-virtual {v0, v4, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    return-object v0

    :catch_0
    :cond_2
    :goto_0
    return-object v1
.end method
