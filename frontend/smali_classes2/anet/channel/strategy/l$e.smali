.class public Lanet/channel/strategy/l$e;
.super Ljava/lang/Object;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lanet/channel/strategy/l;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "e"
.end annotation


# instance fields
.field public final a:Ljava/lang/String;

.field public final b:Lanet/channel/strategy/l$a;

.field public final c:Ljava/lang/String;


# direct methods
.method public constructor <init>(Lorg/json/JSONObject;)V
    .locals 1

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const-string v0, "ip"

    .line 31
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$e;->a:Ljava/lang/String;

    const-string v0, "path"

    .line 32
    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lanet/channel/strategy/l$e;->c:Ljava/lang/String;

    .line 33
    new-instance v0, Lanet/channel/strategy/l$a;

    invoke-direct {v0, p1}, Lanet/channel/strategy/l$a;-><init>(Lorg/json/JSONObject;)V

    iput-object v0, p0, Lanet/channel/strategy/l$e;->b:Lanet/channel/strategy/l$a;

    return-void
.end method
