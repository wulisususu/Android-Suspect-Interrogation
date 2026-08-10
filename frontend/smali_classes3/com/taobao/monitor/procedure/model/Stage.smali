.class public Lcom/taobao/monitor/procedure/model/Stage;
.super Ljava/lang/Object;
.source "Stage.java"


# instance fields
.field private final name:Ljava/lang/String;

.field private final timestamp:J


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0,
            0x0
        }
        names = {
            "name",
            "timestamp"
        }
    .end annotation

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/monitor/procedure/model/Stage;->name:Ljava/lang/String;

    iput-wide p2, p0, Lcom/taobao/monitor/procedure/model/Stage;->timestamp:J

    return-void
.end method


# virtual methods
.method public name()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/model/Stage;->name:Ljava/lang/String;

    return-object v0
.end method

.method public timestamp()J
    .locals 2

    iget-wide v0, p0, Lcom/taobao/monitor/procedure/model/Stage;->timestamp:J

    return-wide v0
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/model/Stage;->name:Ljava/lang/String;

    return-object v0
.end method
