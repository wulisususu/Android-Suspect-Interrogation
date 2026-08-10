.class final enum Lcom/taobao/monitor/procedure/ProcedureImpl$Status;
.super Ljava/lang/Enum;
.source "ProcedureImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/procedure/ProcedureImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401a
    name = "Status"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/monitor/procedure/ProcedureImpl$Status;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

.field public static final enum INIT:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

.field public static final enum RUNNING:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

.field public static final enum STOPPED:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 291
    new-instance v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    const-string v1, "INIT"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->INIT:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    new-instance v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    const-string v2, "RUNNING"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->RUNNING:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    new-instance v2, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    const-string v3, "STOPPED"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->STOPPED:Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    filled-new-array {v0, v1, v2}, [Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    move-result-object v0

    sput-object v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->$VALUES:[Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000
        }
        names = {
            "$enum$name",
            "$enum$ordinal"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 290
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/monitor/procedure/ProcedureImpl$Status;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            "name"
        }
    .end annotation

    const-class v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    .line 290
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    return-object p0
.end method

.method public static values()[Lcom/taobao/monitor/procedure/ProcedureImpl$Status;
    .locals 1

    sget-object v0, Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->$VALUES:[Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    .line 290
    invoke-virtual {v0}, [Lcom/taobao/monitor/procedure/ProcedureImpl$Status;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/monitor/procedure/ProcedureImpl$Status;

    return-object v0
.end method
