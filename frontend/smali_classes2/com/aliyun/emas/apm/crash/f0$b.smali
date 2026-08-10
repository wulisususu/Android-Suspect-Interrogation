.class Lcom/aliyun/emas/apm/crash/f0$b;
.super Lorg/json/JSONObject;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/f0;->a(Lcom/aliyun/emas/apm/crash/k0;)Ljava/lang/String;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/k0;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/k0;)V
    .locals 2

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/f0$b;->a:Lcom/aliyun/emas/apm/crash/k0;

    .line 1
    invoke-direct {p0}, Lorg/json/JSONObject;-><init>()V

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/k0;->b()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/k0;->b()Ljava/lang/String;

    move-result-object v0

    const-string v1, "carrier"

    invoke-virtual {p0, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 7
    :cond_0
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/k0;->a()Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/k0;->a()Ljava/lang/String;

    move-result-object p1

    const-string v0, "access"

    invoke-virtual {p0, v0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    return-void
.end method
