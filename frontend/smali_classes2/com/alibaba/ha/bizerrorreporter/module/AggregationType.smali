.class public final enum Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;
.super Ljava/lang/Enum;
.source "AggregationType.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

.field public static final enum CONTENT:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

.field public static final enum STACK:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;


# instance fields
.field private name:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 13
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    const/4 v1, 0x0

    const-string/jumbo v2, "\u6309\u5806\u6808\u805a\u5408\uff0c\u4f20\u5165\u5806\u6808\u5bf9\u8c61throwable"

    const-string v3, "STACK"

    invoke-direct {v0, v3, v1, v2}, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->STACK:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    .line 14
    new-instance v1, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    const/4 v2, 0x1

    const-string/jumbo v3, "\u6839\u636e\u5185\u5bb9\u805a\u5408\uff0c\u65e0\u5806\u6808\u7684\u9519\u8bef\u5c31\u6839\u636e\u5185\u5bb9\u805a\u5408"

    const-string v4, "CONTENT"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v1, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->CONTENT:Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    filled-new-array {v0, v1}, [Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->$VALUES:[Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x1000,
            0x1000,
            0x0
        }
        names = {
            "$enum$name",
            "$enum$ordinal",
            "name"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 18
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->name:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            "name"
        }
    .end annotation

    const-class v0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    .line 11
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    return-object p0
.end method

.method public static values()[Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->$VALUES:[Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    .line 11
    invoke-virtual {v0}, [Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/alibaba/ha/bizerrorreporter/module/AggregationType;

    return-object v0
.end method
