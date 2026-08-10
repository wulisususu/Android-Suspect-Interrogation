.class public final enum Lcom/alibaba/ha/adapter/Plugin;
.super Ljava/lang/Enum;
.source "Plugin.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/alibaba/ha/adapter/Plugin;",
        ">;"
    }
.end annotation


# static fields
.field public static final synthetic $VALUES:[Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum apm:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum crashreporter:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum olympic:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum telescope:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum tlog:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum ut:Lcom/alibaba/ha/adapter/Plugin;

.field public static final enum watch:Lcom/alibaba/ha/adapter/Plugin;


# direct methods
.method public static constructor <clinit>()V
    .locals 10

    .line 11
    new-instance v0, Lcom/alibaba/ha/adapter/Plugin;

    const-string v1, "crashreporter"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/alibaba/ha/adapter/Plugin;->crashreporter:Lcom/alibaba/ha/adapter/Plugin;

    .line 12
    new-instance v1, Lcom/alibaba/ha/adapter/Plugin;

    const-string v2, "apm"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/alibaba/ha/adapter/Plugin;->apm:Lcom/alibaba/ha/adapter/Plugin;

    .line 13
    new-instance v2, Lcom/alibaba/ha/adapter/Plugin;

    const-string v3, "telescope"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/alibaba/ha/adapter/Plugin;->telescope:Lcom/alibaba/ha/adapter/Plugin;

    .line 14
    new-instance v3, Lcom/alibaba/ha/adapter/Plugin;

    const-string v4, "ut"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/alibaba/ha/adapter/Plugin;->ut:Lcom/alibaba/ha/adapter/Plugin;

    .line 15
    new-instance v4, Lcom/alibaba/ha/adapter/Plugin;

    const-string v5, "watch"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/alibaba/ha/adapter/Plugin;->watch:Lcom/alibaba/ha/adapter/Plugin;

    .line 16
    new-instance v5, Lcom/alibaba/ha/adapter/Plugin;

    const-string v6, "tlog"

    const/4 v7, 0x5

    invoke-direct {v5, v6, v7}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/alibaba/ha/adapter/Plugin;->tlog:Lcom/alibaba/ha/adapter/Plugin;

    .line 17
    new-instance v6, Lcom/alibaba/ha/adapter/Plugin;

    const-string v7, "networkmonitor"

    const/4 v8, 0x6

    invoke-direct {v6, v7, v8}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v6, Lcom/alibaba/ha/adapter/Plugin;->networkmonitor:Lcom/alibaba/ha/adapter/Plugin;

    .line 18
    new-instance v7, Lcom/alibaba/ha/adapter/Plugin;

    const-string v8, "olympic"

    const/4 v9, 0x7

    invoke-direct {v7, v8, v9}, Lcom/alibaba/ha/adapter/Plugin;-><init>(Ljava/lang/String;I)V

    sput-object v7, Lcom/alibaba/ha/adapter/Plugin;->olympic:Lcom/alibaba/ha/adapter/Plugin;

    filled-new-array/range {v0 .. v7}, [Lcom/alibaba/ha/adapter/Plugin;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/adapter/Plugin;->$VALUES:[Lcom/alibaba/ha/adapter/Plugin;

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 10
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/alibaba/ha/adapter/Plugin;
    .locals 1

    const-class v0, Lcom/alibaba/ha/adapter/Plugin;

    .line 10
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/alibaba/ha/adapter/Plugin;

    return-object p0
.end method

.method public static values()[Lcom/alibaba/ha/adapter/Plugin;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/Plugin;->$VALUES:[Lcom/alibaba/ha/adapter/Plugin;

    .line 10
    invoke-virtual {v0}, [Lcom/alibaba/ha/adapter/Plugin;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/alibaba/ha/adapter/Plugin;

    return-object v0
.end method
