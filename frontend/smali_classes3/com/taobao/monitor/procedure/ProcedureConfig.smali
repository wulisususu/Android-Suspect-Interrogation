.class public Lcom/taobao/monitor/procedure/ProcedureConfig;
.super Ljava/lang/Object;
.source "ProcedureConfig.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;
    }
.end annotation


# instance fields
.field private final independent:Z

.field private final parent:Lcom/taobao/monitor/procedure/IProcedure;

.field private final parentNeedStats:Z

.field private final upload:Z


# direct methods
.method private constructor <init>(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)V
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "builder"
        }
    .end annotation

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 11
    invoke-static {p1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->access$000(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->upload:Z

    .line 12
    invoke-static {p1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->access$100(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->independent:Z

    .line 13
    invoke-static {p1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->access$200(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Lcom/taobao/monitor/procedure/IProcedure;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    .line 14
    invoke-static {p1}, Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;->access$300(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)Z

    move-result p1

    iput-boolean p1, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->parentNeedStats:Z

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;Lcom/taobao/monitor/procedure/ProcedureConfig$1;)V
    .locals 0

    .line 3
    invoke-direct {p0, p1}, Lcom/taobao/monitor/procedure/ProcedureConfig;-><init>(Lcom/taobao/monitor/procedure/ProcedureConfig$Builder;)V

    return-void
.end method


# virtual methods
.method public getParent()Lcom/taobao/monitor/procedure/IProcedure;
    .locals 1

    iget-object v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->parent:Lcom/taobao/monitor/procedure/IProcedure;

    return-object v0
.end method

.method public isIndependent()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->independent:Z

    return v0
.end method

.method public isParentNeedStats()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->parentNeedStats:Z

    return v0
.end method

.method public isUpload()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/procedure/ProcedureConfig;->upload:Z

    return v0
.end method
