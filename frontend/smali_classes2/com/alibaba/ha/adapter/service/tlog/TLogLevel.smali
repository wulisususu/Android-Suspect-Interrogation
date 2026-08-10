.class public final enum Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;
.super Ljava/lang/Enum;
.source "TLogLevel.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;",
        ">;"
    }
.end annotation


# static fields
.field public static final synthetic $VALUES:[Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

.field public static final enum DEBUG:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

.field public static final enum ERROR:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

.field public static final enum INFO:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

.field public static final enum VERBOSE:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

.field public static final enum WARN:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;


# direct methods
.method public static constructor <clinit>()V
    .locals 7

    .line 11
    new-instance v0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    const-string v1, "ERROR"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->ERROR:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 12
    new-instance v1, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    const-string v2, "WARN"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->WARN:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 13
    new-instance v2, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    const-string v3, "INFO"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->INFO:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 14
    new-instance v3, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    const-string v4, "DEBUG"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->DEBUG:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 15
    new-instance v4, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    const-string v5, "VERBOSE"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->VERBOSE:Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    filled-new-array {v0, v1, v2, v3, v4}, [Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    move-result-object v0

    sput-object v0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->$VALUES:[Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

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

.method public static valueOf(Ljava/lang/String;)Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;
    .locals 1

    const-class v0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 10
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    return-object p0
.end method

.method public static values()[Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->$VALUES:[Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    .line 10
    invoke-virtual {v0}, [Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/alibaba/ha/adapter/service/tlog/TLogLevel;

    return-object v0
.end method
