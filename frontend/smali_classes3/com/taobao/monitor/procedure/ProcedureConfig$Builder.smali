.class public Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
.super Ljava/lang/Object;
.source "ProcedureConfig.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/procedure/ProcedureConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private independent:Z

.field private parent:Lcom/taobao/monitor/procedure/IProcedure;

.field private parentNeedStats:Z

.field private upload:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 44
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z
    .locals 0

    .line 33
    iget-boolean p0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->upload:Z

    return p0
.end method

.method static synthetic access$100(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z
    .locals 0

    .line 33
    iget-boolean p0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->independent:Z

    return p0
.end method

.method static synthetic access$200(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Lcom/taobao/monitor/procedure/IProcedure;
    .locals 0

    .line 33
    iget-object p0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p0
.end method

.method static synthetic access$300(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z
    .locals 0

    .line 33
    iget-boolean p0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->parentNeedStats:Z

    return p0
.end method


# virtual methods
.method public build()Lcom/taobao/monitor/procedure/ProcedureConfig;
    .locals 2

    .line 69
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureConfig;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/taobao/monitor/procedure/ProcedureConfig;-><init>(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;Lcom/taobao/monitor/procedure/ProcedureConfig$1;)V

    return-object v0
.end method

.method public setIndependent(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "independent"
        }
    .end annotation

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->independent:Z

    return-object p0
.end method

.method public setParent(Lcom/taobao/monitor/procedure/IProcedure;)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "parent"
        }
    .end annotation

    iput-object p1, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    return-object p0
.end method

.method public setParentNeedStats(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "parentNeedStats"
        }
    .end annotation

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->parentNeedStats:Z

    return-object p0
.end method

.method public setUpload(Z)Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "upload"
        }
    .end annotation

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->upload:Z

    return-object p0
.end method
