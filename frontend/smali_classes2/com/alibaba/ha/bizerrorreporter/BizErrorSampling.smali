.class public final enum Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;
.super Ljava/lang/Enum;
.source "BizErrorSampling.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum All:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum OnePercent:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum OneTenThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum OneTenth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum OneThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

.field public static final enum Zero:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 18
    new-instance v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v1, "OneTenth"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneTenth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 19
    new-instance v1, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v2, "OnePercent"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OnePercent:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 20
    new-instance v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v3, "OneThousandth"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 21
    new-instance v3, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v4, "OneTenThousandth"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->OneTenThousandth:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 22
    new-instance v4, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v5, "Zero"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->Zero:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 23
    new-instance v5, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    const-string v6, "All"

    const/4 v7, 0x5

    invoke-direct {v5, v6, v7}, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->All:Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    filled-new-array/range {v0 .. v5}, [Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->$VALUES:[Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

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

    .line 17
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;
    .locals 1
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8000
        }
        names = {
            "name"
        }
    .end annotation

    const-class v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 17
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    return-object p0
.end method

.method public static values()[Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->$VALUES:[Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    .line 17
    invoke-virtual {v0}, [Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/alibaba/ha/bizerrorreporter/BizErrorSampling;

    return-object v0
.end method
